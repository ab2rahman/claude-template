---
name: "design:analyze"
description: "Analyze design image and extract specifications — colors, spacing, typography, layout"
category: "design"
---

# /design:analyze

Analyzes a design image (screenshot, mockup, or URL) and extracts detailed specifications including color palette, spacing/sizing, typography, and layout structure.

## Usage

```bash
/design:analyze [image-path-or-url]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `image-path-or-url` | Yes | Local image path or remote URL to analyze |

## Examples

```bash
/design:analyze ./mockups/home-screen.png
/design:analyze https://example.com/design-screenshot.png
```

## What It Does

1. Accepts an image file path or URL
2. Analyzes the visual design using AI vision
3. Extracts: color palette (hex values), font specs (family, size, weight), spacing values, border radii, shadows, and layout structure
4. Outputs a structured specification document ready for implementation

## Connected Components

- **Skill:** `skill:design/analyze-image`
- **Agent:** `agent:design-analyst-agent`
- **Pattern:** 3 (Command → Skill → Agent)

## Notes

- Supports PNG, JPG, WEBP, and SVG formats
- For best results, use high-resolution images (2x or higher)
- Output can be piped directly into `/design:implement` for code generation
