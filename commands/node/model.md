---
name: "node:model"
description: "Create a Mongoose or Prisma data model with schema"
category: "node"
---

# /node:model

Scaffolds a data model using the project's ORM (Mongoose or Prisma).

## Usage

```
/node:model [model-name]
```

## Arguments

| Argument       | Required | Description                              |
|----------------|----------|------------------------------------------|
| `[model-name]` | Yes      | Name of the model (e.g., User, Product)  |

## Examples

```
/node:model User
/node:model Product
/node:model OrderItem
```

## What It Does

1. Detects ORM (Mongoose or Prisma)
2. Creates model/schema file with typed fields
3. Adds timestamps, indexes, and validation
4. Exports typed model for use in services
5. Updates Prisma schema if applicable

## Connected Components

**Pattern 3 — Skill + Agent**
- **Skill:** `skill:node/create-route`
- **Agent:** `agent:node-dev-agent`

## Notes

- Field types inferred from existing project patterns
- Includes soft-delete and pagination helpers when applicable
