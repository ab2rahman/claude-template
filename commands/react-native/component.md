---
name: "react-native:component"
description: "Create a reusable React Native component with TypeScript types"
category: "react-native"
---

# /react-native:component

Scaffold a reusable React Native component with full TypeScript support.

## Usage

```
/react-native:component [component-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[component-name]` | Yes | Name of the component (PascalCase, e.g. `CustomButton`) |

## Examples

```bash
/react-native:component CustomButton
/react-native:component UserAvatar
/react-native:component SearchBar
```

## What It Does

1. Creates component file at `src/components/[ComponentName]/index.tsx`
2. Generates TypeScript interface for props
3. Creates companion styles file
4. Generates a basic test file for the component
5. Exports from the components barrel file

## Connected Components

- **Agent:** `agent:react-native-dev-agent`

## Notes

- Component names must be PascalCase
- Follows atomic design pattern if directory structure supports it
- Includes JSDoc comments for auto-documentation
