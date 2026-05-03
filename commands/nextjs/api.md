---
name: "nextjs:api"
description: "Create a Next.js API route or Server Action"
category: "nextjs"
---

# /nextjs:api

Scaffolds an API Route Handler or Server Action for data mutations.

## Usage

```
/nextjs:api [api-name]
```

## Arguments

| Argument     | Required | Description                              |
|--------------|----------|------------------------------------------|
| `[api-name]` | Yes      | API endpoint or action name              |

## Examples

```
/nextjs:api users
/nextjs:api auth/login
/nextjs:api actions/create-order
```

## What It Does

1. Detects target: API route vs Server Action
2. Creates route handler with GET/POST/PUT/DELETE stubs
3. Adds request validation with Zod schema
4. Includes error handling and typed responses
5. Follows App Router conventions (route.ts or actions.ts)

## Connected Components

**Pattern 3 — Skill + Agent**
- **Skill:** `skill:nextjs/setup-api`
- **Agent:** `agent:nextjs-dev-agent`

## Notes

- Server Actions are placed in actions/ or co-located with the page
- API routes follow RESTful conventions with proper HTTP methods
