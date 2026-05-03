---
name: "flutter:build"
description: "Build Flutter app for specified platform"
category: "flutter"
---

# /flutter:build

Build the Flutter application for a target platform.

## Usage

```
/flutter:build [platform] [--release|--debug]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `platform` | Yes | Target platform: `apk`, `ios`, `web` |
| `--release` | No | Build in release mode (default) |
| `--debug` | No | Build in debug mode |

## Examples

```
/flutter:build apk              # Build release APK
/flutter:build ios --debug      # Build debug iOS
/flutter:build web              # Build release web
```

## What It Does

1. Runs `flutter build [platform]` with the specified mode
2. Reports build output location and size
3. Flags any build errors or warnings

## Connected Components

None. This is a standalone command (Pattern 1).

## Notes

- iOS builds require a Mac with Xcode installed
- Release builds require proper signing configuration
