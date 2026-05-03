---
name: "kotlin:lint"
description: "Run Kotlin linting with ktlint or detekt"
category: "kotlin"
---

# /kotlin:lint

Run static analysis on Kotlin code using ktlint or detekt.

## Usage

```
/kotlin:lint [--fix]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--fix` | No | Auto-fix formatting and lint issues |

## Examples

```
/kotlin:lint          # Check for lint issues
/kotlin:lint --fix    # Auto-fix issues where possible
```

## What It Does

1. Detects available linter (ktlint or detekt)
2. Runs analysis on all Kotlin source files
3. Reports violations with file, line, and rule description
4. If `--fix`, applies automatic corrections

## Connected Components

None. This is a standalone command (Pattern 1).

## Notes

- Configure ktlint rules in `.editorconfig`
- Configure detekt rules in `detekt.yml`
- Run before committing to maintain code quality
