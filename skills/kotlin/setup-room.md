---
name: "Setup Room Database"
description: "Sets up Room database with Entity, DAO, Repository, and migration support"
category: "kotlin"
---

# Setup Room Database

## Overview

Creates a complete Room persistence layer for a feature: Entity data class, DAO interface with queries, Repository class, and updates the RoomDatabase. Supports migration strategies and integrates with Hilt dependency injection.

## Trigger

This skill is triggered by:
- Command: `/kotlin:room`
- Direct request: "setup room database", "create dao", "add room entity", "add local storage"

## Prerequisites

- Android project with Room dependencies (`room-runtime`, `room-compiler`, `room-ktx`)
- KSP or KAPT configured for annotation processing
- Hilt or manual DI setup for repository injection

## Agent

**Template:** `agents/kotlin-dev-agent.md`

## Workflow

### Step 1: Analyze

- Check existing Room database class for entity and DAO registration pattern
- Identify existing entities for naming and annotation conventions
- Check if migrations directory exists and versioning strategy
- Read repository pattern (if exists) for data layer architecture

### Step 2: Plan

- Define entity fields, primary key, indices, and foreign keys
- Plan DAO methods (insert, update, delete, queries with Flow/LiveData)
- Determine migration strategy if database already exists
- Plan repository pattern (single source of truth with network + local)

### Step 3: Execute

- Create `@Entity` data class with annotations and indices
- Create `@Dao` interface with CRUD operations and Flow queries
- Create Repository class wrapping DAO with error handling
- Update `@Database` class to include new entity and DAO
- Create migration class if version bump is needed
- Add Hilt module for repository injection

### Step 4: Verify

- Build project with `./gradlew assembleDebug` to verify annotation processing
- Confirm database version increment and migration path
- Check DAO queries compile correctly
- Verify Hilt module provides repository

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  SETUP ROOM DATABASE — COMPLETE   ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • data/local/entity/[Name]Entity.kt
║  • data/local/dao/[Name]Dao.kt     ║
║  • data/repository/[Name]Repository.kt
║  • di/[Name]Module.kt (Hilt)       ║
║                                    ║
║  Modified:                         ║
║  • data/local/AppDatabase.kt       ║
║                                    ║
║  Database version: X → Y           ║
║  Migration: Migration_X_Y          ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Basic Entity + DAO

```
/kotlin:room "user" --fields "id:Long,name:String,email:String"
```

Creates UserEntity, UserDao with CRUD, UserRepository.

### Example 2: With Relations

```
/kotlin:room "order-item" --relation "order" --foreign-key
```

Creates OrderItemEntity with foreign key to OrderEntity.

## Error Handling

- **Room not in dependencies:** Add Room dependencies to build.gradle
- **KSP not configured:** Guide KSP plugin setup for Room annotation processing
- **Schema export missing:** Add schema export directory configuration
- **Migration failure:** Suggest fallbackToDestructiveMigration during development
