---
name: "Implement UI"
description: "Converts design specs or images into production-ready UI components with design tokens."
category: "design"
---

# Implement UI

## Overview

Converts design specifications or a design image into production-ready UI code. Creates components with proper design tokens, responsive breakpoints, accessibility attributes, and pixel-accurate styling matching the source design.

## Trigger

This skill is triggered by:
- Command: `/design:implement`
- Direct request: "convert design to code", "implement this UI", "build this component from design"

## Prerequisites

- Design spec document (from `/design:analyze-image`) or design image
- Target framework identified (React, Flutter, SwiftUI, Vue, etc.)
- Design token system in place or willingness to create one

## Agent

**Template:** `agents/design-analyst-agent.md`

Spawns a design-analyst agent to translate design into code components.

## Workflow

### Step 1: Analyze

- Load the design spec or image file
- Identify the target framework and existing project conventions
- Check for existing design tokens, theme, and component library
- Determine the component structure and hierarchy

### Step 2: Plan

- Map design elements to framework-specific components
- Define the component file structure following project conventions
- Identify shared tokens (colors, spacing, typography) to reuse
- Plan responsive breakpoints for different screen sizes

### Step 3: Execute

- Create design token file if not existing (colors, spacing, typography)
- Build each component with proper token references
- Add responsive styles using breakpoints
- Include accessibility attributes (aria labels, semantic elements, contrast)
- Write component tests or Storybook stories if applicable

### Step 4: Verify

- Compare implemented UI against the source design visually
- Check responsive behavior at all breakpoints
- Validate accessibility (contrast ratios, aria labels, keyboard navigation)
- Ensure design tokens are used consistently (no hardcoded values)

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  IMPLEMENT UI — COMPLETE          ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • src/components/[Component].tsx  ║
║  • src/tokens/[tokens].ts          ║
║                                    ║
║  Modified:                         ║
║  • src/styles/theme.ts             ║
║                                    ║
║  Components: [count]               ║
║  Tokens defined: [count]           ║
║  Breakpoints: [list]               ║
║                                    ║
║  Next steps:                       ║
║  • Visual review in browser        ║
║  • Cross-browser testing           ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: From Design Spec

```
/design:implement --spec=docs/design-spec.md --framework=react
```

Expected result: React components with Tailwind CSS or styled-components matching the design spec.

### Example 2: From Image Directly

```
/design:implement "path/to/design.png" --framework=flutter
```

Expected result: Flutter widgets with ThemeData tokens matching the design image.

## Error Handling

- **Missing design tokens:** Create a token file and document the naming convention
- **Framework mismatch:** Confirm the target framework before generating code
- **Pixel accuracy issues:** Adjust spacing and typography, suggest manual fine-tuning
