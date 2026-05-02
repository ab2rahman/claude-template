---
name: "[Skill Name]"
description: "[What this skill does]"
category: "[stack/category]"
---

# [Skill Name]

## Overview

[One paragraph explaining what this skill accomplishes and when to use it.]

## Trigger

This skill is triggered by:
- Command: `/[category]:[command-name]`
- Direct request: "[phrases that should trigger this skill]"

## Prerequisites

- [Required tool/framework version]
- [Required project structure or files]
- [Required dependencies]

## Agent

**Template:** `agents/[agent-name].md`

[If this skill uses an agent, reference it here. If not, remove this section.]

## Workflow

### Step 1: Analyze

- Read relevant project files
- Understand current architecture
- Identify target location for changes

### Step 2: Plan

- List files to create/modify
- Note dependencies to add
- Check for existing patterns

### Step 3: Execute

[Describe the implementation steps specific to this skill]

### Step 4: Verify

- [How to verify the changes work]
- [What tests to run]
- [What to check]

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  [SKILL NAME] — COMPLETE          ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • path/to/file1                   ║
║                                    ║
║  Modified:                         ║
║  • path/to/file2                   ║
║                                    ║
║  Next steps:                       ║
║  • [What to do next]               ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Basic Usage

```
/[category]:[command] "argument"
```

Expected result: [What happens]

### Example 2: With Options

```
/[category]:[command] "argument" --option
```

Expected result: [What happens]

## Error Handling

- **Missing dependency:** [How to handle]
- **File not found:** [How to handle]
- **Test failure:** [How to handle]

## Notes

- [Any additional notes or gotchas]
- [Cross-references to other skills]
