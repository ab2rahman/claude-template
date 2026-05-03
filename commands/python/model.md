---
name: "python:model"
description: "Create SQLAlchemy model with Alembic migration"
category: "python"
---

# /python:model

Generate a new SQLAlchemy model and corresponding Alembic migration file.

## Usage

```bash
/python:model "[model-name]"
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[model-name]` | Yes | Name of the database model to create |

## Examples

### Basic Usage
```bash
/python:model "User"
```

### With Relationships
```bash
/python:model "Order" --relationships
```

## What It Does

1. Analyzes existing models and database patterns
2. Creates SQLAlchemy model with appropriate columns and types
3. Sets up relationships and foreign keys if applicable
4. Generates Alembic migration file
5. Reviews migration for correctness before applying

## Connected Components


- **Skill:** `skill:python/setup-database`
- **Agent:** `agent:python-dev-agent`

## Notes

- Requires SQLAlchemy and Alembic configured in the project
- Migration is generated but NOT auto-applied (review first)
- Follows existing model conventions and naming patterns
