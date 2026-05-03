# Database Patterns Guide

## Schema Design

### Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Tables | `snake_case`, plural | `users`, `order_items` |
| Columns | `snake_case` | `created_at`, `user_id` |
| Primary keys | `id` | `id` |
| Foreign keys | `{table}_id` | `user_id`, `order_id` |
| Indexes | `idx_{table}_{columns}` | `idx_users_email` |
| Unique constraints | `uk_{table}_{columns}` | `uk_users_email` |

### Common Column Patterns

```sql
-- Every table should have these
id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),

-- Soft delete
deleted_at  TIMESTAMPTZ,

-- Audit trail
created_by  UUID REFERENCES users(id),
updated_by  UUID REFERENCES users(id),
```

## Migration Workflow

### Using Alembic (Python)

```bash
# Generate migration from model changes
alembic revision --autogenerate -m "add users table"

# Apply migrations
alembic upgrade head

# Rollback one step
alembic downgrade -1

# Rollback to specific revision
alembic downgrade <revision_id>
```

### Using Prisma (Node.js)

```bash
# Create migration
npx prisma migrate dev --name add_users_table

# Apply to production
npx prisma migrate deploy

# Reset (dev only)
npx prisma migrate reset
```

### Raw SQL Migration Template

```sql
-- Up
-- Migration: 001_create_users_table
-- Created at: 2024-01-15

CREATE TABLE users (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email       VARCHAR(255) NOT NULL,
    name        VARCHAR(100) NOT NULL,
    password    VARCHAR(255) NOT NULL,
    role        VARCHAR(20)  NOT NULL DEFAULT 'user',
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),

    CONSTRAINT uk_users_email UNIQUE (email)
);

CREATE INDEX idx_users_email ON users(email);

-- Down
DROP TABLE IF EXISTS users;
```

## Query Patterns

### Pagination

```sql
-- Cursor-based (recommended for large datasets)
SELECT * FROM products
WHERE created_at < :cursor
ORDER BY created_at DESC
LIMIT :limit + 1;  -- +1 to check if there's a next page

-- Offset-based (simple but slower on large offsets)
SELECT * FROM products
ORDER BY created_at DESC
LIMIT :limit OFFSET :offset;
```

### Soft Delete

```sql
-- Query active records
SELECT * FROM users WHERE deleted_at IS NULL;

-- Soft delete
UPDATE users SET deleted_at = now() WHERE id = :id;

-- Restore
UPDATE users SET deleted_at = NULL WHERE id = :id;
```

### Optimistic Locking

```sql
-- Read with version
SELECT * FROM products WHERE id = :id;  -- returns version = 5

-- Update with version check
UPDATE products
SET name = :name, version = version + 1, updated_at = now()
WHERE id = :id AND version = 5;

-- If affected rows = 0, someone else modified it
```

## Indexing Strategy

### When to Index

| Column Type | Index | Reason |
|-------------|-------|--------|
| Primary key | Auto | Database default |
| Foreign keys | Yes | Join performance |
| Search fields | Yes | WHERE clause lookups |
| Sort fields | Yes | ORDER BY performance |
| Unique constraints | Yes | Data integrity |
| Low cardinality | No | Minimal benefit |
| High-write, low-read | Maybe | Write overhead |

### Composite Index Order

```sql
-- Put equality columns first, range columns last
CREATE INDEX idx_orders_user_status_date
ON orders(user_id, status, created_at DESC);

-- This index serves:
-- WHERE user_id = 1
-- WHERE user_id = 1 AND status = 'active'
-- WHERE user_id = 1 AND status = 'active' AND created_at > '2024-01-01'
```

## Migration Best Practices

### Zero-Downtime Migration

```sql
-- 1. Add nullable column (non-breaking)
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- 2. Deploy code that writes to new column

-- 3. Backfill existing rows in batches
UPDATE users SET phone = '' WHERE phone IS NULL LIMIT 1000;

-- 4. Add NOT NULL constraint (after all rows have values)
ALTER TABLE users ALTER COLUMN phone SET NOT NULL;
```

### Dangerous Operations (Avoid!)

```sql
-- BAD: Locks table
ALTER TABLE users DROP COLUMN email;

-- GOOD: Rename first, deploy code without it, then drop
ALTER TABLE users RENAME COLUMN email TO _deprecated_email;
-- Deploy code that doesn't use _deprecated_email
-- Then in next migration:
ALTER TABLE users DROP COLUMN _deprecated_email;
```

## ERD Template

```
┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│    users     │       │    orders    │       │  products    │
├──────────────┤       ├──────────────┤       ├──────────────┤
│ id (PK)      │──┐    │ id (PK)      │──┐    │ id (PK)      │
│ email (UQ)   │  │    │ user_id (FK) │  │    │ name         │
│ name         │  └──<>│ product_id   │  │    │ price        │
│ password     │       │ quantity     │  └──<>│ stock        │
│ role         │       │ total        │       │ category     │
│ created_at   │       │ status       │       │ created_at   │
│ updated_at   │       │ created_at   │       │ updated_at   │
└──────────────┘       └──────────────┘       └──────────────┘
```

## Commands

| Command | Usage | Pattern |
|---------|-------|---------|
| `/database:query` | Run SQL query | 1 (bash) |
| `/database:migrate` | Create migration | 2 (skill) |
| `/database:schema` | Design schema | 3 (full) |
| `/database:seed` | Generate seed data | 2 (skill) |
| `/database:erd` | Generate ERD | 2 (skill) |
