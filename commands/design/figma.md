---
name: "design:figma"
description: "Figma workflow — import design tokens, extract components from Figma files"
category: "design"
---

# /design:figma

Integrates with Figma to import design tokens, extract component specifications, and sync design system assets into your codebase.

## Usage

```bash
/design:figma [figma-url]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `figma-url` | Yes | Full Figma file or node URL |

## Examples

```bash
/design:figma https://figma.com/design/ABC123/MyApp?node-id=1-2
/design:figma https://figma.com/design/XYZ789/DesignSystem
```

## What It Does

1. Connects to Figma via the provided URL
2. Extracts design tokens: colors, typography, spacing, shadows
3. Identifies reusable components and their variants
4. Outputs tokens in the project's preferred format

## Connected Components

- **Skill:** `skill:design/figma-workflow`
- **Agent:** `agent:design-analyst-agent`
- **Pattern:** 3 (Command → Skill → Agent)

## Notes

- Requires Figma MCP server configured in `.mcp.json`
- Supports component variants, auto-layout specs, and responsive constraints
- Use with `/design:theme` to generate theme files from extracted tokens
