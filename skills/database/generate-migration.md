---
name: "Generate Migration"
description: "Creates database migration files with up/down SQL for schema changes."
category: "database"
---

# Generate Migration

## Overview

Generates database migration files with reversible up/down SQL statements. Analyzes the diff between the current schema and the desired changes, then creates a properly formatted migration file for the project's migration tool.

## Trigger

This skill is triggered by:
- Command: `/database:migrate`
- Direct request: "create a migration", "add migration for", "generate migration file"

## Prerequisites

- Existing migration directory (`migrations/`, `db/migrations/`, or `prisma/migrations/`)
- Migration tool identified (Knex, Sequelize, Prisma, Django, Alembic, etc.)
- Desired schema change described or current schema diff available

## Agent

**Template:** `agents/database-architect-agent.md`

Spawns a database-architect agent to analyze changes and generate the migration.

## Workflow

### Step 1: Analyze

- Scan existing migrations to determine the current migration state
- Identify the migration naming convention and file format in use
- Parse the requested schema change (add table, alter column, create index, etc.)
- Detect the database engine from existing migration files

### Step 2: Plan

- Determine the migration file name following project conventions
- List all SQL operations needed for the "up" migration
- List all reverse operations needed for the "down" migration
- Identify any data migration steps required

### Step 3: Execute

- Create the migration file with proper naming (timestamp + description)
- Write the "up" section with forward schema changes
- Write the "down" section with reversible operations
- Include any data transformation logic if needed
- Add comments for complex operations

### Step 4: Verify

- Validate SQL syntax for the target engine
- Confirm "down" migration reverses "up" exactly
- Check foreign key constraints are valid
- Ensure migration order is correct (latest timestamp)

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  GENERATE MIGRATION — COMPLETE    ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • migrations/[timestamp]_[name].js║
║                                    ║
║  Operations (up):                  ║
║  • [list of schema changes]        ║
║                                    ║
║  Next steps:                       ║
║  • Review the migration file       ║
║  • Run migration on dev database   ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Add Table

```
/database:migrate "add comments table with post_id FK and user_id FK"
```

Expected result: Migration creating `comments` table with foreign keys to `posts` and `users`.

### Example 2: Alter Column

```
/database:migrate "change email column in users to unique not null"
```

Expected result: Migration altering `users.email` to `UNIQUE NOT NULL` with reversible down.

## Error Handling

- **No migrations directory:** Create the directory and suggest migration tool setup
- **Irreversible operation:** Warn user and add a destructive flag check in down migration
- **Naming conflict:** Auto-increment timestamp to avoid collision
