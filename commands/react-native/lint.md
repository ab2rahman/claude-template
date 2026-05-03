---
name: "react-native:lint"
description: "Run ESLint on React Native project"
category: "react-native"
---

# /react-native:lint

Lint the React Native codebase using ESLint with TypeScript support.

## Usage

```
/react-native:lint
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--fix` | No | Automatically fix linting issues |

## Examples

```bash
/react-native:lint
/react-native:lint --fix
```

## What It Does

1. Validates ESLint configuration exists (`.eslintrc.js` or `.eslintrc.json`)
2. Runs `npx eslint . --ext .ts,.tsx`
3. With `--fix`: applies automatic fixes to linting errors
4. Outputs a summary of errors and warnings by severity

## Connected Components

None (Pattern 1 — direct execution).

## Notes

- Requires `eslint`, `@typescript-eslint/parser`, and `@typescript-eslint/eslint-plugin`
- Recommended to run before every commit
- Integrate with `husky` + `lint-staged` for pre-commit hooks
