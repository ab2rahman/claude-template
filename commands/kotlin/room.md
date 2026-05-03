---
name: "kotlin:room"
description: "Set up Room database with Entity, DAO, and Database"
category: "kotlin"
---

# /kotlin:room

Generate Room database components including Entity, DAO, and Database class.

## Usage

```
/kotlin:room [entity-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `entity-name` | Yes | Entity name in PascalCase (e.g., `User`, `Product`, `Order`) |

## Examples

```
/kotlin:room User
/kotlin:room Product
/kotlin:room ChatMessage
```

## What It Does

1. Creates Room Entity data class with annotations
2. Creates DAO interface with CRUD operations
3. Creates abstract Database class
4. Adds TypeConverters if needed for complex types

## Connected Components

- **Skill:** `skill:kotlin/setup-room`
- **Agent:** `agent:kotlin-dev-agent`

## Notes

- Requires `room-runtime`, `room-compiler`, and `room-ktx` dependencies
- Uses Hilt for providing Database instance
