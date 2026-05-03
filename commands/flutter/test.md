---
name: "flutter:test"
description: "Run Flutter tests with optional coverage"
category: "flutter"
---

# /flutter:test

Run Flutter tests for the project.

## Usage

```
/flutter:test [test-path] [--coverage]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `test-path` | No | Specific test file or directory to run |
| `--coverage` | No | Generate coverage report after tests |

## Examples

```
/flutter:test                          # Run all tests
/flutter:test test/widget_test.dart    # Run specific test file
/flutter:test test/widgets/ --coverage # Run directory with coverage
```

## What It Does

1. Runs `flutter test` for the specified path or all tests
2. If `--coverage` is passed, generates an LCOV coverage report
3. Reports test results and any failures

## Connected Components

None. This is a standalone command (Pattern 1).

## Notes

- Ensure `flutter pub get` has been run before testing
- Coverage output is written to `coverage/lcov.info`
