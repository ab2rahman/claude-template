---
name: "flutter:screen"
description: "Create a new Flutter screen with widget, provider, and route"
category: "flutter"
---

# /flutter:screen

Scaffold a complete Flutter screen with all supporting files.

## Usage

```
/flutter:screen [screen-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `screen-name` | Yes | Name of the screen in PascalCase (e.g., `LoginScreen`) |

## Examples

```
/flutter:screen LoginScreen
/flutter:screen ProductDetailScreen
```

## What It Does

1. Creates screen widget file with standard structure
2. Creates Riverpod provider for the screen state
3. Registers route in GoRouter configuration
4. Follows project naming conventions and folder structure

## Connected Components

- **Skill:** `skill:flutter/create-screen`
- **Agent:** `agent:flutter-dev-agent`

## Notes

- Uses project's existing patterns from `memory/` if available
- Screen name should be PascalCase; file names use snake_case
