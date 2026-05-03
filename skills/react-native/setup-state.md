---
name: "Setup React Native State Management"
description: "Sets up Zustand or Redux Toolkit store with actions, selectors, and hooks for a React Native project."
category: "react-native"
---

## Overview

Configures global state management using Zustand (preferred) or Redux Toolkit, creating the store, slices, typed hooks, and connecting them to screens.

## Trigger

User requests state management setup, store creation, or global state in a React Native project.

## Prerequisites

- React Native project with TypeScript
- `zustand` or `@reduxjs/toolkit` + `react-redux` installed
- At least one feature domain identified for the store

## Agent

**Agent Template:** `agents/react-native-dev-agent.md`

Spawn instruction: Pass the state library choice (zustand/redux-toolkit) and the feature domains to model.

## Workflow

### 1. Analyze
- Check for existing store files or state management setup
- Identify feature domains from project structure
- Review existing data models and API types
- Determine preferred library from dependencies

### 2. Plan
- Define store folder structure (stores/ or state/)
- Map out slices/store shape per feature domain
- Plan actions, selectors, and computed values

### 3. Execute
- Create store file with TypeScript types for state
- Define actions/reducers with immutable update patterns
- Create typed hooks (useAppStore, useAppDispatch, useAppSelector)
- Add persistence middleware if needed (AsyncStorage for RN)
- Connect store to screens with usage examples

### 4. Verify
- Confirm TypeScript types are fully inferred
- Verify store connects properly at app root
- Check that actions update state immutably
- Ensure hooks are typed and exported correctly

## Output

```
Created:
  - stores/index.ts               (root store)
  - stores/{feature}Store.ts      (feature slice/store)
  - stores/hooks.ts               (typed hooks)
  - Updated: App.tsx              (provider wrapping, if Redux)
```

## Examples

```
/react-native:setup-state "zustand"
/react-native:setup-state "redux-toolkit with features: auth, cart, products"
```

## Error Handling

- **Missing dependency:** List install command (`npm install zustand` or `npm install @reduxjs/toolkit react-redux`).
- **Existing store found:** Offer to extend rather than overwrite.
- **TypeScript inference issues:** Use explicit generic types on create/combine calls.
