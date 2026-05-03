---
name: "flutter:coverage"
description: "Run Flutter tests and generate coverage report"
category: "flutter"
---

# /flutter:coverage

Run all tests with coverage and generate a readable report.

## Usage

```
/flutter:coverage
```

## Arguments

None.

## Examples

```
/flutter:coverage    # Run tests and generate coverage report
```

## What It Does

1. Runs `flutter test --coverage`
2. Generates `coverage/lcov.info` with coverage data
3. Optionally removes generated file filters for cleaner results
4. Reports overall coverage percentage

## Connected Components

None. This is a standalone command (Pattern 1).

## Notes

- Requires `lcov` package installed for HTML reports (`brew install lcov`)
- Coverage only measures code executed during tests
