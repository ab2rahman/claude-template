---
name: "nextjs:page"
description: "Create a Next.js App Router page with loading and error states"
category: "nextjs"
---

# /nextjs:page

Scaffolds a new App Router page complete with loading.tsx and error.tsx.

## Usage

```
/nextjs:page [page-name]
```

## Arguments

| Argument      | Required | Description                              |
|---------------|----------|------------------------------------------|
| `[page-name]` | Yes      | Route segment name (e.g., dashboard)     |

## Examples

```
/nextjs:page dashboard
/nextjs:page settings/profile
/nextjs:page admin/users
```

## What It Does

1. Creates page.tsx with App Router conventions
2. Creates loading.tsx with skeleton/spinner
3. Creates error.tsx with error boundary
4. Adds metadata exports for SEO
5. Follows Server Component patterns by default

## Connected Components

**Pattern 3 — Skill + Agent**
- **Skill:** `skill:nextjs/create-page`
- **Agent:** `agent:nextjs-dev-agent`

## Notes

- Uses Server Components by default; adds "use client" only when needed
- Nested routes supported with slash-separated paths
