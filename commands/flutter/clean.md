---
name: "flutter:clean"
description: "Clean Flutter build artifacts and re-fetch dependencies"
category: "flutter"
---

# /flutter:clean

Clean the Flutter project and restore dependencies.

## Usage

```
/flutter:clean
```

## Arguments

None.

## Examples

```
/flutter:clean    # Clean and re-fetch dependencies
```

## What It Does

1. Runs `flutter clean` to remove all build artifacts
2. Runs `flutter pub get` to restore dependencies
3. Confirms project is ready for development

## Connected Components

None. This is a standalone command (Pattern 1).

## Notes

- Use when experiencing unexplained build errors
- Safe to run anytime; no data loss
- May take a moment to re-fetch all dependencies
