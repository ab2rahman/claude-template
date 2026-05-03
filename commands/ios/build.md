---
name: "ios:build"
description: "Build and run iOS app using xcodebuild"
category: "ios"
---

# /ios:build

Build and run an iOS application for simulator or physical device.

## Usage

```
/ios:build
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--device` | No | Build for physical device (default: simulator) |
| `--scheme` | No | Xcode scheme name (default: auto-detected) |

## Examples

```bash
/ios:build
/ios:build --device
/ios:build --scheme MyApp --device
```

## What It Does

1. Auto-detects the Xcode project or workspace and scheme
2. For **simulator**: builds and launches in the booted simulator
3. For **device**: builds for a connected physical device
4. Runs `xcodebuild build` with appropriate SDK and destination
5. Installs and launches the app on the target

## Connected Components

None (Pattern 1 — direct execution).

## Notes

- Requires Xcode Command Line Tools installed
- Simulator must be booted via Xcode or `xcrun simctl boot`
- Device builds require valid signing certificate and provisioning profile
