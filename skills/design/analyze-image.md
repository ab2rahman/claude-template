---
name: "Analyze Image"
description: "Extracts design specifications from an image including colors, typography, spacing, and components."
category: "design"
---

# Analyze Image

## Overview

Analyzes a design image (screenshot, mockup, or reference) and extracts detailed specifications: color palette (hex/rgba), typography (fonts, sizes, weights), spacing values, component hierarchy, and layout structure.

## Trigger

This skill is triggered by:
- Command: `/design:analyze`
- Direct request: "analyze this design", "extract design specs", "what colors/fonts are in this image"

## Prerequisites

- Image file accessible (local path or URL)
- Target platform identified (web, iOS, Android) for platform-specific defaults

## Agent

**Template:** `agents/design-analyst-agent.md`

Spawns a design-analyst agent to perform visual analysis and spec extraction.

## Workflow

### Step 1: Analyze

- Load the image and identify the overall layout structure
- Extract the color palette: primary, secondary, accent, background, text colors
- Identify typography: font families, sizes, weights, line heights
- Measure spacing: padding, margins, gaps between elements
- Catalog UI components: buttons, cards, inputs, navigation, etc.

### Step 2: Plan

- Organize extracted specs into a structured document
- Map colors to a design token naming convention
- Group typography by usage (heading, body, caption, etc.)
- Define a component hierarchy from the layout

### Step 3: Execute

- Generate a design specification document in Markdown
- Include color swatches with hex and rgba values
- Document typography scale with CSS/Flutter/SwiftUI equivalents
- List spacing values as design tokens (spacing-xs, spacing-sm, etc.)
- Create a component inventory with descriptions

### Step 4: Verify

- Cross-reference extracted colors against the image for accuracy
- Confirm typography matches visible text styles
- Ensure spacing values are consistent and follow a scale
- Validate component identification covers all visible elements

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  ANALYZE IMAGE — COMPLETE         ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • docs/design-spec.md             ║
║                                    ║
║  Colors extracted: [count]         ║
║  Typography styles: [count]        ║
║  Components identified: [count]    ║
║  Spacing tokens: [count]           ║
║                                    ║
║  Next steps:                       ║
║  • Review extracted specs          ║
║  • Run /design:implement-ui        ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Analyze Screenshot

```
/design:analyze "path/to/mockup.png"
```

Expected result: Full design spec document with colors, typography, spacing, and component inventory.

### Example 2: From URL

```
/design:analyze "https://example.com/design.png" --platform=flutter
```

Expected result: Design specs with Flutter-specific token names and Dart color values.

## Error Handling

- **Image not found:** Verify the file path or URL and prompt user to correct
- **Low resolution:** Warn about reduced accuracy and suggest higher-res source
- **Unrecognizable components:** Flag unknown elements and ask for clarification
