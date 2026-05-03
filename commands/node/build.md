---
name: "node:build"
description: "Build the Node.js project using npm run build or tsc"
category: "node"
---

# /node:build

Runs the project build pipeline — compiles TypeScript, bundles output, and reports errors.

## Usage

```
/node:build [--watch]
```

## Arguments

| Argument  | Required | Description                              |
|-----------|----------|------------------------------------------|
| `--watch` | No       | Watch for file changes and rebuild        |

## Examples

```
/node:build
/node:build --watch
```

## What It Does

1. Detects build tool (npm scripts, tsc, or esbuild)
2. Runs the appropriate build command
3. Reports compilation errors and warnings
4. Confirms output directory and bundle size

## Connected Components

**Pattern 1 — Direct Execution**
- No skill or agent required
- Runs build command directly

## Notes

- Ensure all dependencies are installed (`npm install`) before building
- Use `--watch` during active development for faster feedback loops
