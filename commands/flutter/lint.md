---
name: "flutter:lint"
description: "Run Flutter static analysis and format check"
category: "flutter"
---

# /flutter:lint

Run Flutter analyzer and Dart format check on the project.

## Usage

```
/flutter:lint
```

## Arguments

None.

## Examples

```
/flutter:lint    # Analyze and check formatting
```

## What It Does

1. Runs `flutter analyze` for static code analysis
2. Runs `dart format --set-exit-if-changed .` to check formatting
3. Reports all lint issues, warnings, and formatting problems

## Connected Components

None. This is a standalone command (Pattern 1).

## Notes

- Configure rules in `analysis_options.yaml`
- Run before committing to catch issues early
