---
name: "nextjs:build"
description: "Build the Next.js project with optional bundle analysis"
category: "nextjs"
---

# /nextjs:build

Runs the Next.js production build and optionally analyzes bundle size.

## Usage

```
/nextjs:build [--analyze]
```

## Arguments

| Argument    | Required | Description                              |
|-------------|----------|------------------------------------------|
| `--analyze` | No       | Enable bundle analysis with @next/bundle-analyzer |

## Examples

```
/nextjs:build
/nextjs:build --analyze
```

## What It Does

1. Runs `next build` or `npm run build`
2. Reports build output, route sizes, and warnings
3. With `--analyze`, opens bundle visualization
4. Flags oversized chunks and optimization opportunities

## Connected Components

**Pattern 1 — Direct Execution**
- No skill or agent required
- Runs build command directly

## Notes

- Ensure environment variables are set for production build
- Bundle analysis requires `@next/bundle-analyzer` in devDependencies
