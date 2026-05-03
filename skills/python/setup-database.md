---
name: "Setup Python Database"
description: "Sets up SQLAlchemy ORM with Alembic migrations, models, CRUD operations, and repository pattern."
category: "python"
---

## Overview

Configures database access for a FastAPI application using SQLAlchemy as the ORM and Alembic for migrations. Includes model definitions, session management, CRUD operations, and a repository layer.

## Trigger

- `/python:setup-database` — sets up SQLAlchemy + Alembic from scratch
- `/python:setup-database "<model>"` — sets up database and creates a specific model
- Spawning agent with task: "Setup database with SQLAlchemy and Alembic"

## Prerequisites

- Existing FastAPI project
- Database URL available (PostgreSQL, MySQL, SQLite)
- SQLAlchemy and Alembic will be installed if missing
- Agent template: `agents/python-dev-agent.md`

## Agent

Spawn a general-purpose agent using the `agents/python-dev-agent-agent.md` template with the following task context:

```
Task: Setup SQLAlchemy + Alembic
Database URL: {database_url_env_var}
Base path: {project_src_path}
```

## Workflow

### 1. Analyze
- Check existing database setup in `app/db/`, `app/models/`, or `app/core/`
- Identify existing Alembic configuration
- Review project structure for model organization patterns

### 2. Plan
- Determine database engine (PostgreSQL, MySQL, SQLite)
- Map out model relationships and base model conventions
- Plan Alembic configuration and migration strategy

### 3. Execute
- Create database config: `app/core/database.py` — engine, sessionmaker, Base, get_db dependency
- Create base model: `app/models/base.py` — common columns (id, created_at, updated_at)
- Create models: `app/models/{model}.py` — SQLAlchemy model with relationships
- Configure Alembic: `alembic.ini` + `alembic/env.py` — import Base metadata
- Create initial migration: `alembic revision --autogenerate -m "initial"`
- Create CRUD operations: `app/crud/{model}.py` — create, read, update, delete functions
- Create repository: `app/repositories/{model}_repository.py` — data access layer (optional)

### 4. Verify
- Database connection establishes successfully
- Alembic migration runs without errors (`alembic upgrade head`)
- Models create correct table schema
- CRUD operations work for all basic operations
- Session dependency properly opens and closes sessions

## Output

- SQLAlchemy engine and session configuration
- Base model with common fields
- SQLAlchemy models with relationships
- Alembic configuration and initial migration
- CRUD operations for data access
- Database session dependency for FastAPI

## Examples

```
/python:setup-database
# Creates: core/database.py, models/base.py, alembic.ini, alembic/env.py

/python:setup-database "users"
# Additionally creates: models/user.py, crud/user.py
```

## Error Handling

- If Alembic is already configured, create new migration instead of reinitializing
- If models already exist, extend existing models with new relationships
- If database URL is not set, use SQLite as fallback and add warning
- If SQLAlchemy is not installed, install it along with async driver if needed
