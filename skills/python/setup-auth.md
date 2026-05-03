---
name: "Setup Python Auth"
description: "Sets up FastAPI JWT authentication with auth dependency, login/register routes, and protected endpoints."
category: "python"
---

## Overview

Configures JWT authentication for a FastAPI application including token utilities, authentication dependency, login/register endpoints, and route protection using FastAPI's dependency injection system.

## Trigger

- `/python:setup-auth` — sets up JWT auth from scratch
- Spawning agent with task: "Setup authentication for the FastAPI API"

## Prerequisites

- Existing FastAPI project with router structure
- User model defined (SQLAlchemy or similar)
- python-jose or PyJWT available for JWT operations
- Agent template: `agents/python-dev-agent.md`

## Agent

Spawn a general-purpose agent using the `agents/python-dev-agent.md` template with the following task context:

```
Task: Setup JWT authentication
Base path: {project_src_path}
Existing user model: {yes/no}
```

## Workflow

### 1. Analyze
- Check existing auth in `app/auth/` or `app/dependencies/`
- Identify user model and database session pattern
- Review existing security patterns and CORS configuration

### 2. Plan
- Determine JWT strategy (access token only or access + refresh)
- Map out password hashing approach (bcrypt or passlib)
- Identify which endpoints need authentication vs public access

### 3. Execute
- Create JWT utility: `app/core/security.py` — create_token, verify_token, decode_token
- Create auth dependency: `app/dependencies/auth.py` — get_current_user, get_current_active_user
- Create auth schemas: `app/schemas/auth.py` — LoginRequest, TokenResponse, TokenPayload
- Create auth router: `app/routers/auth.py` — login, register, refresh, me endpoints
- Create password utils: `app/core/password.py` — hash_password, verify_password
- Add JWT_SECRET, JWT_ALGORITHM, JWT_EXPIRES to config/environment
- Register auth router in main application

### 4. Verify
- Login endpoint returns valid JWT token for correct credentials
- Register endpoint creates new user with hashed password
- Protected endpoints reject requests without valid token (401)
- `get_current_user` dependency correctly extracts and validates token
- Token refresh flow works correctly

## Output

- JWT utility for token creation and verification
- FastAPI dependency for authentication
- Auth schemas for request/response validation
- Auth router with login, register, refresh endpoints
- Password hashing utilities
- Environment variables documented

## Examples

```
/python:setup-auth
# Creates: core/security.py, dependencies/auth.py, schemas/auth.py,
#          routers/auth.py, core/password.py
```

## Error Handling

- If auth already exists, extend the existing setup
- If user model doesn't exist, create a basic SQLAlchemy user model
- If passlib/bcrypt is not installed, install and configure automatically
