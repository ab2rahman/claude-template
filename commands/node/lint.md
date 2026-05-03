---
name: "node:lint"
description: "Run ESLint on the Node.js project with optional auto-fix"
category: "node"
---

# /node:lint

Runs ESLint across the project and reports code quality issues.

## Usage

```
/node:lint [--fix]
```

## Arguments

| Argument | Required | Description                              |
|----------|----------|------------------------------------------|
| `--fix`  | No       | Automatically fix lint errors             |

## Examples

```
/node:lint
/node:lint --fix
```

## What It Does

1. Detects ESLint config (.eslintrc or eslint.config.js)
2. Runs `eslint . --ext .ts,.js` with project rules
3. Reports errors and warnings by file
4. Optionally applies auto-fixes

## Connected Components

**Pattern 1 — Direct Execution**
- No skill or agent required
- Runs lint command directly

## Notes

- Ensure ESLint and plugins are installed as devDependencies
- Use `--fix` with caution — review changes before committing
