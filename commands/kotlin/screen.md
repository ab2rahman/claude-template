---
name: "kotlin:screen"
description: "Create Jetpack Compose screen with ViewModel"
category: "kotlin"
---

# /kotlin:screen

Scaffold a Compose screen with its ViewModel and navigation integration.

## Usage

```
/kotlin:screen [screen-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `screen-name` | Yes | Screen name in PascalCase (e.g., `LoginScreen`, `HomeScreen`) |

## Examples

```
/kotlin:screen LoginScreen
/kotlin:screen ProfileScreen
```

## What It Does

1. Creates Compose screen file with scaffold structure
2. Creates ViewModel with StateFlow for UI state
3. Adds sealed interface for screen state
4. Registers route in Navigation Compose graph

## Connected Components

- **Skill:** `skill:kotlin/create-screen`
- **Agent:** `agent:kotlin-dev-agent`

## Notes

- Uses Jetpack Compose and ViewModel conventions
- Follows unidirectional data flow pattern
