---
name: "Setup Node.js Auth"
description: "Sets up JWT authentication middleware with login, register routes, and role-based access control."
category: "node"
---

## Overview

Configures complete JWT authentication for a Node.js API including token generation, verification middleware, login/register endpoints, and role-based access control (RBAC).

## Trigger

- `/node:setup-auth` — sets up JWT auth from scratch
- Spawning agent with task: "Setup authentication for the Node.js API"

## Prerequisites

- Existing Node.js project with Express
- User model/repository already defined (or will be created)
- Access to environment variables for JWT secret
- Agent template: `agents/node-dev-agent.md`

## Agent

Spawn a general-purpose agent using the `agents/node-dev-agent.md` template with the following task context:

```
Task: Setup JWT authentication
Base path: {project_src_path}
Existing user model: {yes/no}
```

## Workflow

### 1. Analyze
- Check existing auth setup in `src/middleware/` or `src/auth/`
- Identify user model and database ORM
- Review existing route protection patterns

### 2. Plan
- Determine token strategy (access + refresh tokens)
- Map out roles and permissions needed
- Identify which routes need protection

### 3. Execute
- Create JWT utility: `src/utils/jwt.ts` — sign, verify, refresh token helpers
- Create auth middleware: `src/middleware/auth.ts` — verify token, attach user to request
- Create role middleware: `src/middleware/roles.ts` — check user roles/permissions
- Create auth routes: `src/routes/auth.routes.ts` — login, register, refresh, logout
- Create auth service: `src/services/auth.service.ts` — credential validation, token management
- Add JWT_SECRET and JWT_EXPIRES_IN to `.env.template`

### 4. Verify
- Confirm tokens are generated and validated correctly
- Test protected routes reject unauthenticated requests
- Verify role-based access blocks unauthorized roles
- Ensure refresh token flow works

## Output

- JWT utility with sign/verify/refresh methods
- Auth middleware for route protection
- Role-based access control middleware
- Auth routes (login, register, refresh, logout)
- Environment variables documented

## Examples

```
/node:setup-auth
# Creates: utils/jwt.ts, middleware/auth.ts, middleware/roles.ts,
#          routes/auth.routes.ts, services/auth.service.ts
```

## Error Handling

- If auth already exists, extend the existing setup rather than replacing
- If no user model exists, create a basic user schema alongside auth
- If bcrypt/argon2 is not installed, install and configure password hashing
