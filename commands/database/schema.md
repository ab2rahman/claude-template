---
name: "database:schema"
description: "Design database schema from requirements"
category: "database"
---

# /database:schema

Design a complete database schema based on natural language requirements description.

## Usage

```bash
/database:schema "[schema-description]"
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[schema-description]` | Yes | Description of the schema to design |

## Examples

### E-commerce Schema
```bash
/database:schema "e-commerce with users, products, orders, and payments"
```

### Blog System
```bash
/database:schema "blog with authors, posts, comments, and categories"
```

## What It Does

1. Parses the requirements description into entities and relationships
2. Designs tables with appropriate columns, types, and constraints
3. Defines primary keys, foreign keys, and indexes
4. Generates CREATE TABLE statements and migration files
5. Produces documentation for the schema design

## Connected Components


- **Skill:** `skill:database/design-schema`
- **Agent:** `agent:database-architect-agent`

## Notes

- Reviews existing schema to avoid conflicts
- Follows normalization best practices (3NF by default)
- Generates both SQL and ORM model representations
