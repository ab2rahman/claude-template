---
name: "ios:screen"
description: "Create a new SwiftUI view with ViewModel"
category: "ios"
---

# /ios:screen

Scaffold a new SwiftUI screen with an accompanying ObservableObject ViewModel.

## Usage

```
/ios:screen [screen-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[screen-name]` | Yes | Name of the screen (PascalCase, e.g. `Login`, `Dashboard`) |

## Examples

```bash
/ios:screen Login
/ios:screen Dashboard
/ios:screen Profile
```

## What It Does

1. Creates SwiftUI view file at `Views/[ScreenName]/[ScreenName]View.swift`
2. Generates a matching ViewModel as `ObservableObject`
3. Sets up the view body with basic layout structure
4. Wires up state management between view and ViewModel
5. Registers the view in the navigation flow if applicable

## Connected Components

- **Skill:** `skill:ios/create-screen`
- **Agent:** `agent:ios-dev-agent`

## Notes

- Screen names must be PascalCase
- Follows MVVM architecture pattern
- Uses `@StateObject` for ViewModel lifecycle management
