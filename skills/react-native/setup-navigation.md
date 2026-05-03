---
name: "Setup React Native Navigation"
description: "Sets up React Navigation with stack, bottom-tabs, or drawer navigators including auth flow and deep linking configuration."
category: "react-native"
---

## Overview

Configures React Navigation from scratch or extends an existing setup, including navigator creation, screen registration, auth flow guards, and optional deep linking.

## Trigger

User requests navigation setup, screen routing, or auth flow in a React Native project.

## Prerequisites

- React Native project with TypeScript
- React Navigation packages installed (`@react-navigation/native`, `@react-navigation/native-stack`, etc.)
- Screen components identified for initial routes

## Agent

**Agent Template:** `agents/react-native-dev-agent.md`

Spawn instruction: Pass navigator types needed (stack, tabs, drawer), screens to register, and whether auth flow is required.

## Workflow

### 1. Analyze
- Check for existing navigation setup or App.tsx structure
- Identify required navigator types from project requirements
- List all screens that need registration
- Determine if auth flow is needed (login/signup vs main app)

### 2. Plan
- Define navigation folder structure (navigation/)
- Map out navigator hierarchy (root -> auth stack + main stack/tabs)
- Define route name constants and param types
- Plan linking configuration for deep links

### 3. Execute
- Create navigator files (AuthNavigator, MainNavigator, RootNavigator)
- Define typed route params using `NativeStackNavigationProp` types
- Register all screens with proper options (header, tabBar, etc.)
- Implement auth flow with conditional navigator rendering
- Configure deep linking if required
- Wrap app in `NavigationContainer` at root

### 4. Verify
- Confirm TypeScript types for all navigation props are correct
- Verify auth flow transitions between stacks properly
- Check that deep link prefixes and config are valid
- Ensure back button behavior is correct on Android

## Output

```
Created:
  - navigation/types.ts              (route params + navigation types)
  - navigation/AuthNavigator.tsx      (auth stack)
  - navigation/MainNavigator.tsx      (main stack/tabs)
  - navigation/RootNavigator.tsx      (root with auth guard)
  - Updated: App.tsx                  (NavigationContainer wrapping)
```

## Examples

```
/react-native:setup-navigation "stack with auth flow"
/react-native:setup-navigation "bottom-tabs: Home, Search, Profile with stack for each"
```

## Error Handling

- **Missing packages:** Provide install commands for required `@react-navigation/*` packages.
- **Type errors in navigation props:** Use properly typed `RouteProp` and `NavigationProp` generics.
- **Auth state not ready:** Add splash/loading screen while checking auth state.
- **Deep links not working:** Verify `uriScheme` is set in `app.json` (expo) or `AndroidManifest.xml`/`Info.plist`.
