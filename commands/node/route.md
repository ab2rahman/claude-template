---
name: "node:route"
description: "Create an Express route with controller and service layer"
category: "node"
---

# /node:route

Scaffolds a new Express route following the route → controller → service pattern.

## Usage

```
/node:route [route-name]
```

## Arguments

| Argument       | Required | Description                              |
|----------------|----------|------------------------------------------|
| `[route-name]` | Yes      | Name of the route (e.g., users, orders)  |

## Examples

```
/node:route users
/node:route orders
/node:route auth/profile
```

## What It Does

1. Creates route file with Express Router
2. Creates controller with CRUD method stubs
3. Creates service layer with business logic skeleton
4. Registers route in the app entry point
5. Adds TypeScript types and interfaces

## Connected Components

**Pattern 3 — Skill + Agent**
- **Skill:** `skill:node/create-route`
- **Agent:** `agent:node-dev-agent`

## Notes

- Follows existing project conventions for naming and structure
- Generated files include JSDoc comments and error handling patterns
