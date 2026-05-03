---
name: "kotlin:build"
description: "Build Android/Kotlin project with Gradle"
category: "kotlin"
---

# /kotlin:build

Build the Kotlin/Android project using Gradle wrapper.

## Usage

```
/kotlin:build [--release]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--release` | No | Build release variant (default is debug) |

## Examples

```
/kotlin:build               # Build debug APK
/kotlin:build --release     # Build release APK
```

## What It Does

1. Runs `./gradlew assembleDebug` or `./gradlew assembleRelease`
2. Reports build output location and APK size
3. Flags any build errors or lint warnings

## Connected Components

None. This is a standalone command (Pattern 1).

## Notes

- Ensure `local.properties` has correct SDK path
- Release builds require signing configuration in `build.gradle`
