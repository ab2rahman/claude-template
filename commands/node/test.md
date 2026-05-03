---
name: "node:test"
description: "Run Node.js tests using npm test or Jest"
category: "node"
---

# /node:test

Executes the project test suite and reports results with coverage options.

## Usage

```
/node:test [test-path] [--coverage]
```

## Arguments

| Argument     | Required | Description                                   |
|--------------|----------|-----------------------------------------------|
| `[test-path]`| No       | Specific test file or directory to run         |
| `--coverage` | No       | Generate test coverage report                  |

## Examples

```
/node:test
/node:test src/services/user.test.ts
/node:test --coverage
/node:test src/auth --coverage
```

## What It Does

1. Detects test runner (Jest, Vitest, or Mocha)
2. Runs targeted or full test suite
3. Reports pass/fail with error details
4. Optionally generates coverage summary

## Connected Components

**Pattern 1 — Direct Execution**
- No skill or agent required
- Runs test command directly

## Notes

- Coverage thresholds are read from jest.config or vitest.config
- Use `[test-path]` to focus on a specific module during development
