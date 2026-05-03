---
name: "Create Python Route"
description: "Creates a FastAPI endpoint with Pydantic models, dependency injection, error handling, and router registration."
category: "python"
---

## Overview

Scaffolds a complete FastAPI endpoint following clean architecture with Pydantic models for request/response validation, dependency injection for services, and structured error handling.

## Trigger

- `/python:create-route "<resource>"` — e.g., `/python:create-route "users"`
- Spawning agent with task: "Create a FastAPI endpoint for <resource>"

## Prerequisites

- Existing FastAPI project with router structure
- Pydantic v2 installed
- Project follows modular router pattern
- Agent template: `agents/python-dev-agent.md`

## Agent

Spawn a general-purpose agent using the `agents/python-dev-agent.md` template with the following task context:

```
Resource: {resource_name}
Base path: {project_src_path}
```

## Workflow

### 1. Analyze
- Check existing routes in `app/routers/` or `app/api/`
- Identify project structure (flat or domain-organized modules)
- Review existing dependency injection patterns and DB session management

### 2. Plan
- Map out CRUD endpoints for the resource
- Identify Pydantic model requirements (create, update, response)
- Determine dependencies (DB session, auth, pagination)

### 3. Execute
- Create Pydantic models: `app/schemas/{resource}.py` — Base, Create, Update, Response schemas
- Create router: `app/routers/{resource}.py` — define endpoints with proper decorators
- Add dependency injection: inject DB session, service layer, auth dependencies
- Add error handling: HTTPException raises with consistent error response model
- Register router: include in `app/main.py` with `app.include_router()`
- Add types: type hints on all parameters and return values

### 4. Verify
- Endpoints appear in `/docs` (Swagger UI) with correct schemas
- Pydantic validation rejects invalid input with 422 errors
- Dependency injection provides DB session and other dependencies
- Router is registered under the correct prefix and tags
- Response models match the Pydantic schemas

## Output

- Pydantic schemas for request/response validation
- FastAPI router with typed CRUD endpoints
- Dependency injection for services and DB access
- Structured error handling
- Router registered in main application

## Examples

```
/python:create-route "users"
# Creates: schemas/users.py, routers/users.py
# Registers: app.include_router(users_router, prefix="/users", tags=["users"])

/python:create-route "orders"
# Creates full CRUD: GET list, GET by id, POST create, PUT update, DELETE
```

## Error Handling

- If Pydantic models already exist for the resource, extend them
- If router pattern doesn't exist, create the structure and document the convention
- If dependency injection is not set up, create basic DB session dependency
