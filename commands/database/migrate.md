---
name: "database:migrate"
description: "Create and manage database migration files"
category: "database"
---

# /database:migrate

Generate a new database migration file with the specified changes.

## Usage

```bash
/database:migrate "[migration-name]"
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[migration-name]` | Yes | Descriptive name for the migration |

## Examples

### Basic Usage
```bash
/database:migrate "add_users_table"
```

### Column Addition
```bash
/database:migrate "add_email_to_users"
```

## What It Does

1. Analyzes current database state and pending changes
2. Generates migration file with up/down functions
3. Includes appropriate schema changes (tables, columns, indexes)
4. Validates migration syntax before saving
5. Shows preview of changes to be applied

## Connected Components


- **Skill:** `skill:database/generate-migration`
- **Agent:** `agent:database-architect-agent`

## Notes

- Requires migration tool configured (Alembic, Knex, Prisma, etc.)
- Migration is created but NOT auto-applied (review first)
- Follows existing migration naming conventions
