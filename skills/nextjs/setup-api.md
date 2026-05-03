---
name: "Setup Next.js API"
description: "Sets up Server Actions and Route Handlers with validation and error handling for Next.js API layer."
category: "nextjs"
---

## Overview

Configures the API layer for a Next.js App Router application using Server Actions for mutations and Route Handlers for external-facing endpoints. Includes Zod validation and structured error handling.

## Trigger

- `/nextjs:setup-api "<resource>"` — e.g., `/nextjs:setup-api "todos"`
- Spawning agent with task: "Setup API layer for <resource>"

## Prerequisites

- Existing Next.js App Router project
- Zod installed or will be installed for validation
- Agent template: `agents/nextjs-dev-agent.md`

## Agent

Spawn a general-purpose agent using the `agents/nextjs-dev-agent.md` template with the following task context:

```
Resource: {resource_name}
Base path: {project_src_path}
```

## Workflow

### 1. Analyze
- Check existing API routes in `app/api/` and server actions in `app/actions/`
- Identify data models and database client
- Review existing error handling patterns

### 2. Plan
- Determine which operations use Server Actions vs Route Handlers
- Map out input/output types for each operation
- Identify validation requirements

### 3. Execute
- Create server actions: `app/actions/{resource}.actions.ts` — mutations (create, update, delete)
- Create route handlers: `app/api/{resource}/route.ts` — GET, POST endpoints
- Add validation: `lib/validations/{resource}.ts` — Zod schemas for input/output
- Create error handler: `lib/api-error.ts` — custom error class and response formatter
- Add types: `types/{resource}.ts` — TypeScript interfaces for the resource

### 4. Verify
- Server Actions work in client components with `use server` directive
- Route Handlers return proper HTTP status codes and JSON responses
- Zod validation rejects invalid inputs with clear error messages
- Error responses follow a consistent format
- TypeScript types align between client and server

## Output

- Server Actions for data mutations
- Route Handlers for external API access
- Zod validation schemas
- Custom error handling utility
- TypeScript type definitions

## Examples

```
/nextjs:setup-api "todos"
# Creates: actions/todos.actions.ts, api/todos/route.ts,
#          lib/validations/todos.ts, lib/api-error.ts, types/todos.ts

/nextjs:setup-api "users"
# Creates full CRUD API layer for users resource
```

## Error Handling

- If Zod is not installed, install it and configure
- If server actions directory doesn't exist, create `app/actions/` structure
- If API routes already exist for the resource, extend rather than replace
