# Python/FastAPI Patterns Guide

## Project Structure

```
app/
├── main.py                     # FastAPI app factory
├── core/
│   ├── config.py               # Settings via pydantic-settings
│   ├── database.py             # SQLAlchemy async session
│   ├── security.py             # JWT, password hashing
│   └── dependencies.py         # Shared FastAPI dependencies
├── models/
│   ├── user.py                 # SQLAlchemy models
│   └── base.py                 # Base model class
├── schemas/
│   ├── user.py                 # Pydantic request/response models
│   └── auth.py
├── routers/
│   ├── auth.py
│   ├── users.py
│   └── health.py
├── services/
│   ├── auth_service.py         # Business logic
│   └── user_service.py
├── repositories/
│   ├── user_repo.py            # Data access layer
│   └── base_repo.py
├── migrations/                 # Alembic migrations
│   ├── env.py
│   └── versions/
├── tests/
│   ├── conftest.py
│   ├── test_auth.py
│   └── test_users.py
└── alembic.ini
```

## App Factory

```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.routers import auth, users, health

def create_app() -> FastAPI:
    app = FastAPI(
        title=settings.PROJECT_NAME,
        version=settings.VERSION,
        docs_url="/api/docs",
    )

    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.ALLOWED_ORIGINS,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    app.include_router(health.router)
    app.include_router(auth.router, prefix="/api/auth", tags=["auth"])
    app.include_router(users.router, prefix="/api/users", tags=["users"])

    return app

app = create_app()
```

## Configuration — Pydantic Settings

```python
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    PROJECT_NAME: str = "My API"
    VERSION: str = "1.0.0"
    DATABASE_URL: str
    JWT_SECRET: str
    JWT_ALGORITHM: str = "HS256"
    JWT_EXPIRE_MINUTES: int = 30
    ALLOWED_ORIGINS: list[str] = ["*"]

    model_config = {"env_file": ".env"}

settings = Settings()
```

## Database — SQLAlchemy 2.0

### Session Setup

```python
from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker, AsyncSession
from app.core.config import settings

engine = create_async_engine(settings.DATABASE_URL, echo=False)
async_session = async_sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

async def get_db() -> AsyncSession:
    async with async_session() as session:
        yield session
```

### Model

```python
from sqlalchemy import String, DateTime
from sqlalchemy.orm import Mapped, mapped_column
from datetime import datetime, timezone
from app.models.base import Base

class User(Base):
    __tablename__ = "users"

    id: Mapped[str] = mapped_column(String(36), primary_key=True)
    email: Mapped[str] = mapped_column(String(255), unique=True, index=True)
    name: Mapped[str] = mapped_column(String(100))
    hashed_password: Mapped[str] = mapped_column(String(255))
    created_at: Mapped[datetime] = mapped_column(DateTime, default=lambda: datetime.now(timezone.utc))
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=lambda: datetime.now(timezone.utc), onupdate=lambda: datetime.now(timezone.utc))
```

## Schemas — Pydantic

```python
from pydantic import BaseModel, EmailStr, Field
from datetime import datetime

class UserBase(BaseModel):
    email: EmailStr
    name: str = Field(min_length=2, max_length=100)

class UserCreate(UserBase):
    password: str = Field(min_length=8, max_length=100)

class UserResponse(UserBase):
    id: str
    created_at: datetime

    model_config = {"from_attributes": True}

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class TokenResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
```

## Router Pattern

```python
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.schemas.user import UserCreate, UserResponse
from app.services.user_service import UserService

router = APIRouter()

@router.post("/", response_model=UserResponse, status_code=201)
async def create_user(
    data: UserCreate,
    db: AsyncSession = Depends(get_db),
):
    service = UserService(db)
    return await service.create(data)

@router.get("/me", response_model=UserResponse)
async def get_current_user(
    current_user=Depends(get_current_user),
):
    return current_user
```

## Service Layer

```python
from sqlalchemy.ext.asyncio import AsyncSession
from app.repositories.user_repo import UserRepository
from app.core.security import hash_password, verify_password, create_token
from app.schemas.user import UserCreate

class UserService:
    def __init__(self, db: AsyncSession):
        self.repo = UserRepository(db)

    async def create(self, data: UserCreate):
        existing = await self.repo.get_by_email(data.email)
        if existing:
            raise HTTPException(status_code=409, detail="Email already registered")

        hashed = hash_password(data.password)
        user = await self.repo.create(email=data.email, name=data.name, hashed_password=hashed)
        return user

    async def authenticate(self, email: str, password: str) -> str:
        user = await self.repo.get_by_email(email)
        if not user or not verify_password(password, user.hashed_password):
            raise HTTPException(status_code=401, detail="Invalid credentials")
        return create_token(user.id)
```

## Repository Pattern

```python
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from app.models.user import User
import uuid

class UserRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_by_id(self, user_id: str) -> User | None:
        return await self.db.get(User, user_id)

    async def get_by_email(self, email: str) -> User | None:
        result = await self.db.execute(select(User).where(User.email == email))
        return result.scalar_one_or_none()

    async def create(self, **kwargs) -> User:
        kwargs.setdefault("id", str(uuid.uuid4()))
        user = User(**kwargs)
        self.db.add(user)
        await self.db.commit()
        await self.db.refresh(user)
        return user
```

## Security

```python
from passlib.context import CryptContext
from jose import jwt
from app.core.config import settings
from datetime import datetime, timedelta, timezone

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(password: str) -> str:
    return pwd_context.hash(password)

def verify_password(plain: str, hashed: str) -> bool:
    return pwd_context.verify(plain, hashed)

def create_token(user_id: str) -> str:
    expire = datetime.now(timezone.utc) + timedelta(minutes=settings.JWT_EXPIRE_MINUTES)
    return jwt.encode({"sub": user_id, "exp": expire}, settings.JWT_SECRET, algorithm=settings.JWT_ALGORITHM)
```

## Testing

```python
import pytest
from httpx import AsyncClient, ASGITransport
from app.main import app

@pytest.fixture
async def client():
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac

@pytest.mark.asyncio
async def test_register(client):
    response = await client.post("/api/auth/register", json={
        "email": "test@test.com",
        "name": "Test",
        "password": "password123",
    })
    assert response.status_code == 201
    assert "id" in response.json()
```

## Commands

| Command | Usage | Pattern |
|---------|-------|---------|
| `/python:build` | Install & check | 1 (bash) |
| `/python:test` | Run tests | 1 (bash) |
| `/python:route` | Create route | 3 (full) |
| `/python:model` | Create model | 2 (skill) |
| `/python:auth` | Setup authentication | 2 (skill) |
| `/python:lint` | Run linter | 1 (bash) |
