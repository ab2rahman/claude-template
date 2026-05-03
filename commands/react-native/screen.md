---
name: "react-native:screen"
description: "Create a new React Native screen with navigation registration"
category: "react-native"
---

# /react-native:screen

Scaffold a new React Native screen component and register it in the navigation stack.

## Usage

```
/react-native:screen [screen-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[screen-name]` | Yes | Name of the screen (PascalCase, e.g. `UserProfile`) |

## Examples

```bash
/react-native:screen Home
/react-native:screen UserProfile
/react-native:screen Settings
```

## What It Does

1. Creates screen component file at `src/screens/[ScreenName]/index.tsx`
2. Generates TypeScript types and styles for the screen
3. Registers the screen in the app's navigation configuration
4. Creates a basic screen template with safe area and styling

## Connected Components

- **Skill:** `skill:react-native/create-screen`
- **Agent:** `agent:react-native-dev-agent`

## Notes

- Screen names must be PascalCase
- Ensures navigation library is installed and configured
- Generates a minimal functional screen ready for customization
