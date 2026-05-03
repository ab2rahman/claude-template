---
name: "Create Next.js Page"
description: "Creates a Next.js App Router page with layout, loading state, error boundary, and metadata."
category: "nextjs"
---

## Overview

Scaffolds a complete Next.js page using the App Router convention, including the page component, layout, loading skeleton, error boundary, and SEO metadata.

## Trigger

- `/nextjs:create-page "<route>"` — e.g., `/nextjs:create-page "dashboard/settings"`
- Spawning agent with task: "Create a Next.js page for <route>"

## Prerequisites

- Existing Next.js project using App Router (`app/` directory)
- Next.js 13+ with TypeScript
- Agent template: `agents/nextjs-dev-agent.md`

## Agent

Spawn a general-purpose agent using the `agents/nextjs-dev-agent.md` template with the following task context:

```
Route: {route_path}
Base path: {project_src_path}/app/
```

## Workflow

### 1. Analyze
- Check existing pages in `app/` directory for conventions
- Identify layout nesting and shared components
- Review existing error/loading patterns

### 2. Plan
- Map the route to the file system (e.g., `dashboard/settings` → `app/dashboard/settings/`)
- Determine if a new layout is needed or if parent layout applies
- Identify reusable components from existing pages

### 3. Execute
- Create page: `app/{route}/page.tsx` — main page component (default export)
- Create loading: `app/{route}/loading.tsx` — Suspense fallback skeleton
- Create error: `app/{route}/error.tsx` — error boundary with reset action
- Create layout (if needed): `app/{route}/layout.tsx` — shared layout for route segment
- Add metadata: export `generateMetadata` or static `metadata` object for SEO
- Add `not-found.tsx` if the page handles dynamic segments

### 4. Verify
- Confirm page renders at the correct URL path
- Loading state shows during async data fetching
- Error boundary catches and displays errors gracefully
- Metadata appears in page `<head>`
- Layout nesting works correctly with parent layouts

## Output

- Page component with default export
- Loading skeleton for Suspense fallback
- Error boundary with retry capability
- Layout if route needs isolated layout
- SEO metadata configuration

## Examples

```
/nextjs:create-page "dashboard/settings"
# Creates: app/dashboard/settings/page.tsx, loading.tsx, error.tsx

/nextjs:create-page "blog/[slug]"
# Creates: app/blog/[slug]/page.tsx, loading.tsx, error.tsx, not-found.tsx
```

## Error Handling

- If page already exists, suggest extending rather than overwriting
- If using Pages Router, adapt output to `pages/` convention with getServerSideProps
- If layout already exists for parent route, skip layout creation
