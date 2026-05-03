---
name: "react-native:nav"
description: "Set up React Navigation with stack, tab, or drawer navigator"
category: "react-native"
---

# /react-native:nav

Initialize or update React Navigation configuration in the project.

## Usage

```
/react-native:nav
```

## Arguments

No arguments required. Interactive setup.

## Examples

```bash
/react-native:nav
```

## What It Does

1. Checks for existing navigation setup in the project
2. Installs required React Navigation dependencies if missing
3. Configures navigation container at the app root
4. Sets up the navigator type (stack, tab, or drawer) based on project needs
5. Creates a navigation types file for type-safe navigation
6. Links screens to the navigator

## Connected Components

- **Skill:** `skill:react-native/setup-navigation`
- **Agent:** `agent:react-native-dev-agent`

## Notes

- Installs `@react-navigation/native` and related packages
- Requires `react-native-screens` and `react-native-safe-area-context`
- Run `npx pod-install` for iOS after setup
