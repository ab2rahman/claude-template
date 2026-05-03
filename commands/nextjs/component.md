---
name: "nextjs:component"
description: "Create a React component with TypeScript and best practices"
category: "nextjs"
---

# /nextjs:component

Scaffolds a typed React component following project conventions.

## Usage

```
/nextjs:component [component-name]
```

## Arguments

| Argument          | Required | Description                              |
|-------------------|----------|------------------------------------------|
| `[component-name]`| Yes      | Component name in PascalCase             |

## Examples

```
/nextjs:component UserCard
/nextjs:component ProductList
/nextjs:component Navigation/Header
```

## What It Does

1. Creates component file with TypeScript interface
2. Includes props typing and default exports
3. Adds JSDoc comments for documentation
4. Creates co-located test file if testing is configured
5. Follows Server/Client component conventions

## Connected Components

**Pattern 2 — Command + Agent**
- **Agent:** `agent:nextjs-dev-agent`

## Notes

- Detects whether component should be Server or Client based on usage
- Follows existing component patterns in the project
