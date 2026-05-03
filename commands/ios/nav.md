---
name: "ios:nav"
description: "Set up SwiftUI NavigationStack with route management"
category: "ios"
---

# /ios:nav

Initialize or update SwiftUI NavigationStack with type-safe route management.

## Usage

```
/ios:nav
```

## Arguments

No arguments required. Interactive setup.

## Examples

```bash
/ios:nav
```

## What It Does

1. Checks for existing navigation setup in the project
2. Creates a `NavigationRouter` with typed route definitions
3. Sets up `NavigationStack` with `navigationDestination` modifiers
4. Configures root view and initial navigation flow
5. Creates a `Route` enum for type-safe navigation paths
6. Adds navigation bar styling and transition configuration

## Connected Components

- **Skill:** `skill:ios/setup-navigation`
- **Agent:** `agent:ios-dev-agent`

## Notes

- Uses iOS 16+ NavigationStack API
- Supports sheet and full-screen cover presentations
- Can integrate with deep linking and coordinator pattern
