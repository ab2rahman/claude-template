---
name: "flutter:widget-test"
description: "Generate widget test file and run tests"
category: "flutter"
---

# /flutter:widget-test

Generate a widget test file for an existing widget and run it.

## Usage

```
/flutter:widget-test [widget-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `widget-name` | Yes | Widget name in PascalCase to generate tests for |

## Examples

```
/flutter:widget-test LoginButton
/flutter:widget-test ProductCard
```

## What It Does

1. Locates the widget source file
2. Generates a test file with pumpWidget setup
3. Includes basic render and interaction test stubs
4. Runs `flutter test` on the generated file

## Connected Components

None. This is a standalone command (Pattern 1).

## Notes

- Test file is created in the corresponding `test/` directory
- Uses `testing` package conventions for widget tests
