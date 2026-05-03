---
name: "design:implement"
description: "Convert design image to production code — Flutter, React Native, or Next.js"
category: "design"
---

# /design:implement

Converts a design image (screenshot or mockup) into production-ready UI code for the specified stack. Supports Flutter, React Native, and Next.js.

## Usage

```bash
/design:implement [image-path-or-url] --stack [stack]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `image-path-or-url` | Yes | Local image path or remote URL of the design |
| `--stack` | No | Target stack: `flutter`, `react-native`, `nextjs` (default: `flutter`) |

## Examples

```bash
/design:implement ./mockups/login.png --stack flutter
/design:implement https://example.com/ui.png --stack react-native
/design:implement ./designs/dashboard.png --stack nextjs
```

## What It Does

1. Analyzes the design image for visual specs
2. Maps design elements to target framework components
3. Generates responsive, production-ready code
4. Outputs widget/component files with proper styling

## Connected Components

- **Skill:** `skill:design/implement-ui`
- **Agent:** `agent:design-analyst-agent`
- **Pattern:** 3 (Command → Skill → Agent)

## Notes

- Pair with `/design:analyze` for spec extraction only (no code)
- Generates files following project conventions when available
- Supports responsive layouts and adaptive designs
