---
name: "Create React Native Screen"
description: "Creates a new screen component with TypeScript and registers it in the navigation system."
category: "react-native"
---

## Overview

Generates a fully typed React Native screen component, its styles, and registers it in the app's navigation (stack or bottom-tabs).

## Trigger

User requests a new screen, page, or view in a React Native project.

## Prerequisites

- React Native project with TypeScript configured
- React Navigation installed (`@react-navigation/native`, `@react-navigation/native-stack` or `@react-navigation/bottom-tabs`)
- Existing navigation structure to extend

## Agent

**Agent Template:** `agents/react-native-dev-agent.md`

Spawn instruction: Pass screen name, navigation type (stack/bottom-tabs), and any props/params the screen expects.

## Workflow

### 1. Analyze
- Locate existing navigation files (navigator, stack/tab config)
- Identify navigation type (Stack, Bottom Tabs, Drawer)
- Check existing screens for naming conventions and patterns
- Determine folder structure (screens per feature vs flat)

### 2. Plan
- Define screen file path and component name
- Determine route params type if applicable
- Identify where to insert navigation registration

### 3. Execute
- Create screen component with TypeScript interface for props/params
- Implement screen with safe area handling and basic layout
- Create co-located or shared styles (StyleSheet)
- Register screen in the appropriate navigator
- Export screen from barrel file if pattern exists

### 4. Verify
- Confirm TypeScript compiles without errors
- Verify navigation registration matches existing pattern
- Check imports are correct and complete

## Output

```
Created:
  - screens/{ScreenName}/index.tsx        (screen component)
  - screens/{ScreenName}/styles.ts        (StyleSheet)
  - Updated: navigation/{Navigator}.tsx    (route registration)
```

## Examples

```
/react-native:create-screen "Profile"
/react-native:create-screen "OrderHistory with params orderId: string"
```

## Error Handling

- **Navigation file not found:** Prompt user to run `setup-navigation` first.
- **TypeScript errors:** Ensure all type imports and route params are properly defined.
- **Duplicate screen name:** Warn user and suggest renaming or updating existing screen.
