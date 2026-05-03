---
name: "react-native:state"
description: "Set up state management with Zustand or Redux"
category: "react-native"
---

# /react-native:state

Scaffold a state management store using Zustand (preferred) or Redux Toolkit.

## Usage

```
/react-native:state [store-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[store-name]` | Yes | Name of the store (camelCase, e.g. `userStore`, `cartStore`) |

## Examples

```bash
/react-native:state userStore
/react-native:state cartStore
/react-native:state appState
```

## What It Does

1. Creates store file at `src/stores/[storeName].ts`
2. Defines TypeScript interfaces for state and actions
3. Implements the store with Zustand (or Redux Toolkit if preferred)
4. Creates a custom hook for accessing the store
5. Sets up persistence middleware if needed

## Connected Components

- **Skill:** `skill:react-native/setup-state`
- **Agent:** `agent:react-native-dev-agent`

## Notes

- Zustand is the default choice for lighter bundle size
- Supports async actions for API calls
- Can integrate with `mmkv` or `async-storage` for persistence
