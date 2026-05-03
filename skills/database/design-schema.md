---
name: "Design Schema"
description: "Designs database schema from requirements, generating ERD and SQL DDL."
category: "database"
---

# Design Schema

## Overview

Designs a complete database schema from natural-language requirements. Identifies entities, relationships, and constraints, then produces an ERD and executable SQL DDL for the target database engine.

## Trigger

This skill is triggered by:
- Command: `/database:schema`
- Direct request: "design a database schema", "create database tables from requirements", "model this data"

## Prerequisites

- Requirements document or user-provided description of the domain
- Target database engine identified (PostgreSQL, MySQL, SQLite, etc.)
- Project exists with a `migrations/` or `db/` directory

## Agent

**Template:** `agents/database-architect-agent.md`

Spawns a database-architect agent to perform the full schema design workflow.

## Workflow

### Step 1: Analyze

- Parse the provided requirements for entities, attributes, and relationships
- Identify cardinality (one-to-one, one-to-many, many-to-many)
- Determine data types and constraints for each attribute
- Note any soft-delete, audit, or multi-tenancy requirements

### Step 2: Plan

- List all tables with their columns, types, and constraints
- Define primary keys, foreign keys, and indexes
- Map many-to-many relationships through junction tables
- Choose naming conventions matching existing project style

### Step 3: Execute

- Generate SQL DDL `CREATE TABLE` statements for each entity
- Generate junction tables for many-to-many relationships
- Add indexes for frequently queried columns
- Create an ERD in Mermaid or PlantUML format
- Write the output to `db/schema.sql` or `migrations/`

### Step 4: Verify

- Validate SQL syntax against the target engine
- Confirm all foreign keys reference valid tables
- Ensure no circular dependencies exist
- Check that all requirements are covered

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  DESIGN SCHEMA — COMPLETE         ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • db/schema.sql                   ║
║  • docs/erd.md                     ║
║                                    ║
║  Tables:  [count]                  ║
║  Relationships:  [count]           ║
║                                    ║
║  Next steps:                       ║
║  • Review schema with team         ║
║  • Run /database:generate-migration║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Basic Usage

```
/database:schema "e-commerce with users, products, orders, and reviews"
```

Expected result: Full schema with users, products, orders, order_items, reviews tables and ERD.

### Example 2: With Options

```
/database:schema "blog system" --engine=postgresql --soft-delete --audit
```

Expected result: PostgreSQL schema with soft-delete columns and audit timestamps on all tables.

## Error Handling

- **Ambiguous requirements:** Prompt user for clarification on entity relationships
- **Unsupported engine:** Fall back to standard SQL and note engine-specific features
- **Circular dependency:** Suggest restructuring and ask user for confirmation
