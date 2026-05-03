---
name: "python:auth"
description: "Set up JWT/OAuth authentication with FastAPI"
category: "python"
---

# /python:auth

Configure authentication system with JWT or OAuth2 for a FastAPI application.

## Usage

```bash
/python:auth
/python:auth --provider [provider]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--provider` | No | Auth provider (jwt, oauth2, google, github). Default: jwt |

## Examples

### JWT Authentication
```bash
/python:auth
```

### OAuth2 with Google
```bash
/python:auth --provider google
```

## What It Does

1. Analyzes existing project structure and user model
2. Creates authentication middleware and dependencies
3. Implements login, register, and token refresh endpoints
4. Sets up password hashing with bcrypt
5. Configures OAuth2 provider integration if specified

## Connected Components


- **Skill:** `skill:python/setup-auth`
- **Agent:** `agent:python-dev-agent`

## Notes

- Requires an existing User model (use `/python:model "User"` first)
- Environment variables needed: SECRET_KEY, ALGORITHM, etc.
- Follows FastAPI security best practices
