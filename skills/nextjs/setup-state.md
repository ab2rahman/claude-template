---
name: "Setup Next.js State"
description: "Sets up client-side state management using Zustand or React Context with server state integration."
category: "nextjs"
---

## Overview

Configures client-side state management for a Next.js application using Zustand (default) or React Context. Includes store creation, provider setup, custom hooks, and integration with server state (React Query/SWR).

## Trigger

- `/nextjs:setup-state "<store>"` — e.g., `/nextjs:setup-state "cart"`
- `/nextjs:setup-state --library context` — use Context instead of Zustand
- Spawning agent with task: "Setup state management for <store>"

## Prerequisites

- Existing Next.js App Router project
- Client components identified that need shared state
- Agent template: `agents/nextjs-dev-agent.md`

## Agent

Spawn a general-purpose agent using the `agents/nextjs-dev-agent.md` template with the following task context:

```
Store name: {store_name}
Library: {zustand|context}
Base path: {project_src_path}
```

## Workflow

### 1. Analyze
- Check existing state management in `store/`, `lib/store/`, or `providers/`
- Identify client components that consume shared state
- Review existing data fetching patterns (Server Components vs Client)

### 2. Plan
- Choose state library (Zustand for simplicity, Context for small scope)
- Map out state shape, actions, and computed values
- Determine which state is client-only vs server-hydrated

### 3. Execute
- Create store: `lib/store/{store}.ts` — Zustand store or Context definition
- Create provider: `providers/{store}-provider.tsx` — client component wrapper
- Create hooks: `hooks/use-{store}.ts` — custom hook for accessing store
- Create types: `types/{store}.ts` — state interface and action types
- Integrate with server state: combine with React Query/SWR for async data
- Add provider to root layout: `app/layout.tsx`

### 4. Verify
- Store initializes with correct default state
- Actions update state and trigger re-renders
- Provider wraps the correct component subtree
- Custom hooks provide typed access to state and actions
- Server state (React Query) and client state (Zustand) work together

## Output

- Zustand store or React Context with typed state and actions
- Provider component for layout integration
- Custom hooks for clean state access
- TypeScript types for state shape
- Integration guide for server state

## Examples

```
/nextjs:setup-state "cart"
# Creates: lib/store/cart.ts, providers/cart-provider.tsx,
#          hooks/use-cart.ts, types/cart.ts

/nextjs:setup-state "theme" --library context
# Creates React Context-based theme provider
```

## Error Handling

- If Zustand is not installed, install it automatically
- If provider already exists in layout, add new provider alongside existing ones
- If mixing server and client state, clearly document the boundary
