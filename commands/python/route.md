---
name: "python:route"
description: "Create FastAPI route with Pydantic model"
category: "python"
---

# /python:route

Generate a new FastAPI endpoint with request/response Pydantic models.

## Usage

```bash
/python:route "[route-name]"
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[route-name]` | Yes | Name of the route/endpoint to create |

## Examples

### Basic Usage
```bash
/python:route "user-profile"
```

### CRUD Route Set
```bash
/python:route "products" --crud
```

## What It Does

1. Analyzes existing project structure and routing patterns
2. Creates Pydantic request/response models for the endpoint
3. Generates the FastAPI router with proper path operations
4. Registers the router in the main application
5. Includes input validation and error handling

## Connected Components


- **Skill:** `skill:python/create-route`
- **Agent:** `agent:python-dev-agent`

## Notes

- Requires FastAPI project structure
- Follows existing project conventions for route organization
- Auto-generates OpenAPI documentation via FastAPI
