---
name: "flutter:provider"
description: "Set up Riverpod state management for a feature"
category: "flutter"
---

# /flutter:provider

Create Riverpod provider structure for a feature module.

## Usage

```
/flutter:provider [feature-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `feature-name` | Yes | Feature name in snake_case (e.g., `auth`, `cart`) |

## Examples

```
/flutter:provider auth
/flutter:provider shopping_cart
```

## What It Does

1. Creates provider file with Riverpod notifier/state classes
2. Sets up state model with copyWith pattern
3. Creates abstract repository interface for DI
4. Follows project's state management conventions

## Connected Components

- **Skill:** `skill:flutter/setup-provider`
- **Agent:** `agent:flutter-dev-agent`

## Notes

- Requires `flutter_riverpod` package in `pubspec.yaml`
- Generates both state and notifier classes
