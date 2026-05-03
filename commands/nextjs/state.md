---
name: "nextjs:state"
description: "Set up Zustand store or React Context for state management"
category: "nextjs"
---

# /nextjs:state

Scaffolds a Zustand store or React Context provider for client-side state.

## Usage

```
/nextjs:state [store-name]
```

## Arguments

| Argument      | Required | Description                              |
|---------------|----------|------------------------------------------|
| `[store-name]`| Yes      | Name of the store or context             |

## Examples

```
/nextjs:state cart
/nextjs:state user-auth
/nextjs:state theme
```

## What It Does

1. Detects preferred state solution (Zustand or Context)
2. Creates store file with typed state and actions
3. Includes persist middleware if needed (Zustand)
4. Creates provider component (Context) or hook export (Zustand)
5. Adds usage examples in comments

## Connected Components

**Pattern 3 — Skill + Agent**
- **Skill:** `skill:nextjs/setup-state`
- **Agent:** `agent:nextjs-dev-agent`

## Notes

- Zustand is preferred for complex state; Context for simple prop drilling
- Persist middleware uses localStorage by default
