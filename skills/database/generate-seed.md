---
name: "Generate Seed"
description: "Generates realistic seed data scripts for database development and testing."
category: "database"
---

# Generate Seed

## Overview

Generates seed data scripts populated with realistic fake data based on the existing database schema. Creates executable seed files that can be run repeatedly without causing constraint violations.

## Trigger

This skill is triggered by:
- Command: `/database:seed`
- Direct request: "generate seed data", "create seed script", "populate test data"

## Prerequisites

- Existing database schema (tables defined in code or migration files)
- Seed directory present (`seeds/`, `db/seeds/`, or equivalent)
- Faker library or equivalent available in the project

## Agent

**Pattern 2: Inline Execution**

This skill runs directly without spawning a separate agent. The workflow is executed inline.

## Workflow

### Step 1: Analyze

- Read the database schema from migration files or schema definitions
- Identify all tables, columns, data types, and constraints
- Detect foreign key relationships and dependency order
- Note unique constraints and check constraints

### Step 2: Plan

- Determine seed data volume (default: 10-50 rows per table)
- Define the insertion order respecting foreign key dependencies
- Map columns to appropriate faker methods
- Plan for unique constraint handling

### Step 3: Execute

- Generate the seed script file following project conventions
- Populate each table with realistic fake data using faker
- Handle foreign keys by inserting parent tables first
- Include idempotent patterns (truncate/reseed or upsert)
- Add the seed file to `seeds/` directory

### Step 4: Verify

- Validate the seed script syntax
- Confirm foreign key references point to valid parent data
- Check unique constraints are not violated
- Run the seed script against a development database if possible

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  GENERATE SEED — COMPLETE         ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • seeds/001_[table]_seed.js       ║
║  • seeds/002_[table]_seed.js       ║
║                                    ║
║  Tables seeded: [count]            ║
║  Rows per table: ~[count]          ║
║                                    ║
║  Next steps:                       ║
║  • Run seeds against dev database  ║
║  • Verify data integrity           ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Seed All Tables

```
/database:seed
```

Expected result: Seed files for all tables with realistic data.

### Example 2: Seed Specific Table

```
/database:seed --table=users --count=100
```

Expected result: Seed file for `users` table with 100 rows of fake user data.

## Error Handling

- **No schema found:** Prompt user to run `/database:design-schema` first
- **Faker not installed:** Suggest installation and provide alternative with hardcoded sample data
- **Circular FK dependency:** Break the cycle with deferred constraints or nullable FKs
