---
name: "Figma Workflow"
description: "Integrates with Figma to extract design tokens, import components, and sync design updates."
category: "design"
---

# Figma Workflow

## Overview

Integrates with Figma through the Figma API to extract design tokens, import components, generate code from Figma nodes, and keep the codebase in sync with design changes.

## Trigger

This skill is triggered by:
- Command: `/design:figma`
- Direct request: "import from figma", "sync figma design", "extract figma tokens"

## Prerequisites

- Figma API access configured (token in environment variables)
- Figma file URL or file key available
- Target framework identified for code generation

## Agent

**Template:** `agents/design-analyst-agent.md`

Spawns a design-analyst agent to handle Figma API interactions and code generation.

## Workflow

### Step 1: Analyze

- Connect to Figma using the configured API token
- Read the Figma file structure and identify pages/frames
- Extract design tokens: colors, typography, spacing, shadows
- Identify reusable components and component variants

### Step 2: Plan

- Map Figma components to code component structure
- Determine which tokens to extract (colors, typography, spacing, effects)
- Identify Figma nodes that need image asset export
- Plan the sync strategy (full export or incremental diff)

### Step 3: Execute

- Extract design tokens and write to token files (JSON, CSS, or Dart)
- Import component definitions with props/variants mapping
- Generate code components from Figma nodes using Code Connect
- Export image assets (icons, illustrations) at required resolutions
- Create a sync manifest tracking Figma node IDs to code files

### Step 4: Verify

- Confirm all extracted tokens match Figma values
- Validate generated component code compiles without errors
- Check that component variants cover all Figma variants
- Ensure image assets are exported at correct resolutions

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  FIGMA WORKFLOW — COMPLETE        ║
╠════════════════════════════════════╣
║                                    ║
║  Extracted tokens:                 ║
║  • Colors: [count]                 ║
║  • Typography: [count]             ║
║  • Spacing: [count]                ║
║                                    ║
║  Components synced: [count]        ║
║  Assets exported: [count]          ║
║                                    ║
║  Created:                          ║
║  • src/tokens/figma-tokens.json    ║
║  • src/components/                 ║
║                                    ║
║  Next steps:                       ║
║  • Review generated components     ║
║  • Set up Figma webhook for sync   ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Full Sync

```
/design:figma "https://figma.com/design/abc123/MyApp"
```

Expected result: All tokens, components, and assets extracted from the Figma file.

### Example 2: Tokens Only

```
/design:figma --tokens-only --file=abc123
```

Expected result: Only design tokens (colors, typography, spacing) extracted to token files.

## Error Handling

- **API token invalid:** Prompt user to check `FIGMA_TOKEN` environment variable
- **File not found:** Verify the file key from the URL and check permissions
- **Rate limited:** Implement exponential backoff and retry the request
