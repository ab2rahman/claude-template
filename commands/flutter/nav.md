---
name: "flutter:nav"
description: "Set up GoRouter navigation for the project"
category: "flutter"
---

# /flutter:nav

Configure GoRouter navigation with route definitions.

## Usage

```
/flutter:nav
```

## Arguments

None.

## Examples

```
/flutter:nav    # Initialize or update navigation setup
```

## What It Does

1. Sets up GoRouter configuration file
2. Defines route structure based on existing screens
3. Configures navigation guards and redirects
4. Creates navigation helper utilities

## Connected Components

- **Skill:** `skill:flutter/setup-navigation`
- **Agent:** `agent:flutter-dev-agent`

## Notes

- Requires `go_router` package in `pubspec.yaml`
- Scans existing screens to suggest route definitions
