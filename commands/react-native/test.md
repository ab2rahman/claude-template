---
name: "react-native:test"
description: "Run React Native tests with Jest"
category: "react-native"
---

# /react-native:test

Run the React Native test suite using Jest.

## Usage

```
/react-native:test [test-path]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[test-path]` | No | Specific test file or directory to run |
| `--coverage` | No | Generate test coverage report |

## Examples

```bash
/react-native:test
/react-native:test src/__tests__/App.test.tsx
/react-native:test --coverage
```

## What It Does

1. Checks for Jest configuration in `package.json` or `jest.config.js`
2. Runs `npx jest` with optional test path filter
3. With `--coverage`: adds `--coverage` flag and outputs coverage summary
4. Displays test results with pass/fail summary

## Connected Components

None (Pattern 1 — direct execution).

## Notes

- Ensure all dependencies are installed (`npm install` or `yarn`)
- Coverage reports output to `coverage/` directory
- Use `--watch` mode manually for development workflow
