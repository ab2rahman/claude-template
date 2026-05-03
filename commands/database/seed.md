---
name: "database:seed"
description: "Generate and insert seed data for database tables"
category: "database"
---

# /database:seed

Generate realistic seed data and insert it into the specified database table.

## Usage

```bash
/database:seed "[table-name]"
/database:seed "[table-name]" --count 50
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[table-name]` | Yes | Target table to seed |
| `--count` | No | Number of records to generate (default: 10) |

## Examples

### Basic Seeding
```bash
/database:seed "users"
```

### Custom Count
```bash
/database:seed "products" --count 50
```

## What It Does

1. Inspects table schema to determine column types and constraints
2. Generates realistic seed data respecting foreign keys and validations
3. Creates a seed file for repeatability
4. Inserts data into the database
5. Reports inserted record count

## Connected Components


- **Skill:** `skill:database/generate-seed`
- **Agent:** None (Pattern 2)

## Notes

- Respects existing data and avoids unique constraint violations
- Seed files are saved for future re-use
- Uses Faker library patterns for realistic data
