---
name: "ios:test"
description: "Run iOS unit and UI tests using xcodebuild"
category: "ios"
---

# /ios:test

Run the iOS test suite for the specified scheme.

## Usage

```
/ios:test [scheme]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[scheme]` | No | Xcode scheme to test (default: auto-detected) |

## Examples

```bash
/ios:test
/ios:test MyApp
/ios:test MyAppTests
```

## What It Does

1. Auto-detects the Xcode project/workspace and available schemes
2. Identifies the test target for the given scheme
3. Runs `xcodebuild test` with the iOS simulator destination
4. Parses and displays test results with pass/fail counts
5. Reports code coverage if enabled in the scheme

## Connected Components

None (Pattern 1 — direct execution).

## Notes

- Requires a booted simulator for UI tests
- Unit tests run against the host architecture
- Enable code coverage in the Xcode scheme for coverage reports
