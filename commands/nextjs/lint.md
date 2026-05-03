---
name: "nextjs:lint"
description: "Run Next.js linting with ESLint and optional auto-fix"
category: "nextjs"
---

# /nextjs:lint

Runs `next lint` to check code quality across the Next.js project.

## Usage

```
/nextjs:lint [--fix]
```

## Arguments

| Argument | Required | Description                              |
|----------|----------|------------------------------------------|
| `--fix`  | No       | Automatically fix lint errors             |

## Examples

```
/nextjs:lint
/nextjs:lint --fix
```

## What It Does

1. Runs `next lint` with project ESLint configuration
2. Reports errors and warnings by file
3. Checks for Next.js-specific best practices
4. Optionally applies auto-fixes

## Connected Components

**Pattern 1 — Direct Execution**
- No skill or agent required
- Runs lint command directly

## Notes

- Requires ESLint to be configured (run `next lint` once to set up)
- Use `--fix` cautiously — review changes before committing
