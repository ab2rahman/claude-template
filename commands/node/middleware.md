---
name: "node:middleware"
description: "Create authentication or validation middleware for Express"
category: "node"
---

# /node:middleware

Scaffolds Express middleware for authentication, validation, or custom logic.

## Usage

```
/node:middleware [middleware-name]
```

## Arguments

| Argument            | Required | Description                                  |
|---------------------|----------|----------------------------------------------|
| `[middleware-name]` | Yes      | Name of the middleware (e.g., auth, validate) |

## Examples

```
/node:middleware auth
/node:middleware validate-request
/node:middleware rate-limit
```

## What It Does

1. Creates middleware file with Express Handler signature
2. Adds request validation / auth check logic
3. Includes error handling and next() flow
4. Registers middleware in the app where appropriate

## Connected Components

**Pattern 3 — Skill + Agent**
- **Skill:** `skill:node/setup-auth`
- **Agent:** `agent:node-dev-agent`

## Notes

- Supports JWT, session-based, and API key auth patterns
- Validation middleware integrates with Joi or Zod schemas
