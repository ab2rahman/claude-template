---
name: "Create iOS Screen"
description: "Creates a SwiftUI view with its ObservableObject ViewModel, model, and preview for an iOS project."
category: "ios"
---

## Overview

Generates a complete SwiftUI screen following the MVVM pattern: a typed View, an ObservableObject ViewModel, a data Model, and a live preview for Xcode Canvas.

## Trigger

User requests a new screen, view, or page in an iOS/SwiftUI project.

## Prerequisites

- Xcode project with SwiftUI enabled (iOS 16+ target recommended)
- MVVM folder structure in place or to be created
- Knowledge of the screen's data requirements

## Agent

**Agent Template:** `agents/ios-dev-agent.md`

Spawn instruction: Pass screen name, data model description, and any API or navigation dependencies.

## Workflow

### 1. Analyze
- Locate existing Views/ViewModels/Models folders
- Identify naming conventions from existing screens
- Check for shared components or design system in use
- Determine data flow (API-driven, local, Core Data)

### 2. Plan
- Define file paths for View, ViewModel, and Model
- Determine state and binding requirements
- Identify reusable components to leverage

### 3. Execute
- Create Model struct conforming to `Codable` / `Identifiable` as needed
- Create ViewModel class conforming to `ObservableObject` with `@Published` properties
- Create SwiftUI View with `@StateObject` or `@ObservedObject` for ViewModel
- Add navigation, list/grid layout, and loading/error states
- Add `#Preview` macro block for Xcode Canvas

### 4. Verify
- Confirm ViewModel publishes state changes correctly
- Verify View binds to ViewModel without force unwraps
- Check Model conforms to required protocols
- Ensure preview compiles and renders in Canvas

## Output

```
Created:
  - Features/{ScreenName}/{ScreenName}View.swift
  - Features/{ScreenName}/{ScreenName}ViewModel.swift
  - Features/{ScreenName}/{ScreenName}Model.swift
```

## Examples

```
/ios:create-screen "Profile"
/ios:create-screen "ProductList with models: Product(id, name, price, image)"
```

## Error Handling

- **Missing feature folder:** Create the feature group/folder automatically.
- **Ambiguous state ownership:** Use `@StateObject` for View-owned VMs, `@ObservedObject` for injected VMs.
- **Preview crash:** Ensure mock data is provided in the preview block and no network calls run in init.
