---
name: "kotlin:nav"
description: "Set up Navigation Compose for the project"
category: "kotlin"
---

# /kotlin:nav

Configure Jetpack Navigation Compose with route definitions.

## Usage

```
/kotlin:nav
```

## Arguments

None.

## Examples

```
/kotlin:nav    # Initialize or update navigation setup
```

## What It Does

1. Sets up NavHost and NavController configuration
2. Defines route structure based on existing screens
3. Creates type-safe route definitions
4. Adds deep link support if applicable

## Connected Components

- **Skill:** `skill:kotlin/setup-navigation`
- **Agent:** `agent:kotlin-dev-agent`

## Notes

- Requires `navigation-compose` dependency
- Uses type-safe navigation with Kotlin Serialization
