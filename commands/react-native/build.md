---
name: "react-native:build"
description: "Build and run React Native app on Android or iOS"
category: "react-native"
---

# /react-native:build

Build and run a React Native application on the specified platform.

## Usage

```
/react-native:build [platform]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[platform]` | Yes | Target platform: `android` or `ios` |
| `--release` | No | Build in release mode (default: debug) |

## Examples

```bash
/react-native:build android
/react-native:build ios
/react-native:build android --release
```

## What It Does

1. Validates the target platform argument
2. For **android**: runs `npx react-native run-android`
3. For **ios**: runs `npx react-native run-ios`
4. With `--release`: appends `--variant=release` (Android) or `--configuration=Release` (iOS)
5. Starts Metro bundler if not already running

## Connected Components

None (Pattern 1 — direct execution).

## Notes

- Ensure Metro bundler or a connected device/emulator is running before build
- iOS builds require Xcode and CocoaPods (`cd ios && pod install`)
- Android builds require Android SDK and an emulator or physical device
