---
name: "kotlin:test"
description: "Run Kotlin/Android unit tests"
category: "kotlin"
---

# /kotlin:test

Run unit tests for the Kotlin/Android project.

## Usage

```
/kotlin:test [module]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `module` | No | Specific Gradle module to test (e.g., `:app`, `:core`) |

## Examples

```
/kotlin:test              # Run all tests
/kotlin:test :app         # Run tests for app module
/kotlin:test :core:data   # Run tests for core:data module
```

## What It Does

1. Runs `./gradlew test` for the specified module or all modules
2. Reports test results with pass/fail counts
3. Highlights any test failures with stack traces

## Connected Components

None. This is a standalone command (Pattern 1).

## Notes

- Use `--info` flag for verbose test output
- Instrumentation tests require `./gradlew connectedAndroidTest`
