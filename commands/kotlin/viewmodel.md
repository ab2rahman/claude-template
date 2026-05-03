---
name: "kotlin:viewmodel"
description: "Create ViewModel with StateFlow and sealed state"
category: "kotlin"
---

# /kotlin:viewmodel

Generate a ViewModel with StateFlow and sealed state class for a feature.

## Usage

```
/kotlin:viewmodel [feature-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `feature-name` | Yes | Feature name in PascalCase (e.g., `Auth`, `Cart`, `Profile`) |

## Examples

```
/kotlin:viewmodel Auth
/kotlin:viewmodel ShoppingCart
```

## What It Does

1. Creates ViewModel class with StateFlow
2. Generates sealed interface for UI state (Loading, Success, Error)
3. Sets up intent/event handling methods
4. Includes Hilt injection annotation

## Connected Components

- **Skill:** `skill:kotlin/create-screen`
- **Agent:** `agent:kotlin-dev-agent`

## Notes

- Requires `lifecycle-viewmodel-compose` dependency
- Uses Hilt for dependency injection by default
