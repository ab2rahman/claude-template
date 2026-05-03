---
name: "ios:viewmodel"
description: "Create an ObservableObject ViewModel for a feature"
category: "ios"
---

# /ios:viewmodel

Scaffold a standalone ObservableObject ViewModel for a feature module.

## Usage

```
/ios:viewmodel [feature-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[feature-name]` | Yes | Name of the feature (PascalCase, e.g. `Auth`, `Search`) |

## Examples

```bash
/ios:viewmodel Auth
/ios:viewmodel Search
/ios:viewmodel Cart
```

## What It Does

1. Creates ViewModel file at `ViewModels/[FeatureName]ViewModel.swift`
2. Defines the class conforming to `ObservableObject`
3. Declares `@Published` properties for view state
4. Sets up input methods and output publishers
5. Includes error handling and loading state management

## Connected Components

- **Agent:** `agent:ios-dev-agent`

## Notes

- Follows MVVM architecture with clear separation of concerns
- Can be paired with `/ios:screen` for full screen + ViewModel setup
- Supports Combine framework for reactive bindings
