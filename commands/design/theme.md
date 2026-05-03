---
name: "design:theme"
description: "Create design tokens and theme file for the specified format"
category: "design"
---

# /design:theme

Creates a design tokens/theme file from extracted specifications or manual input. Outputs in Dart, TypeScript, or CSS format.

## Usage

```bash
/design:theme [theme-name] --format [format]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `theme-name` | Yes | Name for the theme (e.g., `appTheme`, `darkTheme`) |
| `--format` | No | Output format: `dart`, `ts`, `css` (default: `dart`) |

## Examples

```bash
/design:theme appTheme --format dart
/design:theme darkTheme --format ts
/design:theme globalStyles --format css
```

## What It Does

1. Collects design specs from context or previous analysis
2. Structures tokens into colors, typography, spacing, elevations, etc.
3. Generates a complete theme file with proper naming conventions
4. Outputs ready-to-use theme configuration

## Connected Components

- **Skill:** `skill:design/implement-ui`
- **Agent:** `agent:design-analyst-agent`
- **Pattern:** 3 (Command → Skill → Agent)

## Notes

- Works best after `/design:analyze` or `/design:figma` provides specs
- Supports light/dark mode token generation
- Follows Material Design 3 conventions for Flutter output
