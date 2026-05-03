---
name: "nextjs:test"
description: "Run Next.js tests using Jest or Playwright"
category: "nextjs"
---

# /nextjs:test

Executes unit, integration, or end-to-end tests for the Next.js project.

## Usage

```
/nextjs:test [test-path] [--e2e]
```

## Arguments

| Argument     | Required | Description                                   |
|--------------|----------|-----------------------------------------------|
| `[test-path]`| No       | Specific test file or directory to run         |
| `--e2e`      | No       | Run end-to-end tests with Playwright           |

## Examples

```
/nextjs:test
/nextjs:test src/components/Button.test.tsx
/nextjs:test --e2e
/nextjs:test e2e/auth.spec.ts --e2e
```

## What It Does

1. Detects test runner (Jest, Vitest, or Playwright)
2. Runs unit/integration tests by default
3. With `--e2e`, launches Playwright browser tests
4. Reports results with failure details

## Connected Components

**Pattern 1 — Direct Execution**
- No skill or agent required
- Runs test command directly

## Notes

- E2E tests require Playwright configured and browsers installed
- Unit tests use @testing-library/react by convention
