---
name: "nextjs:layout"
description: "Create a Next.js layout template with metadata and structure"
category: "nextjs"
---

# /nextjs:layout

Scaffolds a layout.tsx with nested routing structure and metadata.

## Usage

```
/nextjs:layout [layout-name]
```

## Arguments

| Argument       | Required | Description                              |
|----------------|----------|------------------------------------------|
| `[layout-name]`| Yes      | Layout route segment (e.g., admin, dash) |

## Examples

```
/nextjs:layout admin
/nextjs:layout dashboard
/nextjs:layout (marketing)
```

## What It Does

1. Creates layout.tsx with proper nesting structure
2. Adds metadata exports for SEO (title, description, icons)
3. Includes shared UI elements (nav, sidebar, footer)
4. Sets up proper children prop typing
5. Follows App Router layout conventions

## Connected Components

**Pattern 2 — Command + Agent**
- **Agent:** `agent:nextjs-dev-agent`

## Notes

- Route groups use parentheses syntax: `(marketing)`
- Layouts wrap all child routes — use sparingly for shared chrome
