---
name: "database:query"
description: "Execute SQL query via database CLI"
category: "database"
---

# /database:query

Run SQL queries directly against the database using psql, mysql, or sqlite3 CLI.

## Usage

```bash
/database:query "[query]"
/database:query --file [path]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[query]` | Yes* | SQL query string to execute |
| `--file` | No | Path to .sql file to execute |
| `--database` | No | Target database name (uses default if omitted) |

*One of `[query]` or `--file` is required.

## Examples

### Inline Query
```bash
/database:query "SELECT * FROM users LIMIT 10"
```

### From File
```bash
/database:query --file "migrations/cleanup.sql"
```

## What It Does

1. Detects database type from environment configuration
2. Connects using appropriate CLI (psql, mysql, sqlite3)
3. Executes the query and formats output as a table
4. Shows row count and execution time

## Connected Components

*Simple command (Pattern 1). No skill or agent required.*

## Notes

- Requires database credentials in environment variables
- Read-only queries recommended; use with caution for DML
- Output is formatted for readability in terminal
