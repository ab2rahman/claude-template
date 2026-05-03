---
name: "Setup iOS Navigation"
description: "Sets up SwiftUI NavigationStack with typed destinations, navigation bar configuration, and deep link support."
category: "ios"
---

## Overview

Configures SwiftUI NavigationStack (iOS 16+) with strongly-typed navigation destinations, toolbar setup, and optional deep link handling using the modern `NavigationPath` approach.

## Trigger

User requests navigation setup, screen routing, or deep linking in an iOS/SwiftUI project.

## Prerequisites

- Xcode project targeting iOS 16+ (for NavigationStack)
- SwiftUI views already created or being created
- Understanding of the navigation hierarchy (flat vs drill-down)

## Agent

**Agent Template:** `agents/ios-dev-agent.md`

Spawn instruction: Pass the navigation structure (tabs, drill-down, modal), destinations, and deep link requirements.

## Workflow

### 1. Analyze
- Check for existing navigation setup (NavigationView, NavigationStack, TabView)
- Identify all destinations and their data requirements
- Determine navigation patterns (push, sheet, fullScreenCover)
- Check for existing deep link configuration in Info.plist / App entry

### 2. Plan
- Define `NavigationDestination` enum or `Codable` route types
- Map out navigation hierarchy (root -> destinations)
- Plan toolbar/title configuration per screen
- Design deep link URL scheme and route mapping

### 3. Execute
- Create typed route enum conforming to `Codable` / `Hashable`
- Create `NavigationStack` with `navigationDestination(for:)` modifiers
- Configure toolbar items, titles, and bar appearance per view
- Add `NavigationPath`-based coordinator if complex routing needed
- Configure deep links in `App` entry point using `onOpenURL`
- Add `TabView` wrapper if tab-based navigation is required

### 4. Verify
- Confirm all destinations are registered with `navigationDestination`
- Verify back navigation and toolbar behave correctly
- Check deep link URLs route to the correct destination
- Ensure NavigationPath serialization works for state restoration

## Output

```
Created:
  - Navigation/Router.swift             (route enum + NavigationPath)
  - Navigation/NavigationCoordinator.swift  (optional coordinator)
  - Updated: Features/*View.swift       (navigationDestination modifiers)
  - Updated: App.swift                  (onOpenURL for deep links)
```

## Examples

```
/ios:setup-navigation "push navigation with destinations: Home, Profile, Settings"
/ios:setup-navigation "tab-based: Home, Search, Profile with deep links"
```

## Error Handling

- **iOS 15 target:** Fall back to `NavigationView` with `.navigationBarItems` and warn about deprecated API.
- **Missing destinations:** Ensure every case in the route enum has a matching `navigationDestination(for:)`.
- **Deep link not opening:** Verify URL scheme is registered in `Info.plist` (`CFBundleURLSchemes`).
- **Navigation path explosion:** Use coordinator pattern for complex flows with many destinations.
