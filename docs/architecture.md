# Architecture — Three-Tier Command System

## Overview

This template uses a **three-tier architecture** for organizing Claude Code commands:

```
╔════════════════════════════════════════════════════════════╗
║                   COMMAND → SKILL → AGENT                 ║
╠════════════════════════════════════════════════════════════╣
║                                                            ║
║  COMMAND  (commands/)                                      ║
║    ↓ User-facing shortcut                                  ║
║    ↓ Contains: YAML frontmatter, usage examples            ║
║                                                            ║
║  SKILL    (skills/)                                        ║
║    ↓ Orchestrator                                          ║
║    ↓ Contains: Agent template reference, spawn instructions║
║                                                            ║
║  AGENT    (agents/)                                        ║
║    ↓ Worker (autonomous process)                           ║
║    ↓ Contains: Workflow, steps, return format             ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
```

## Why Three Tiers?

| Problem | Solution |
|---------|----------|
| Commands get too long | Commands stay short, delegate to skills |
| Same workflow repeated | Skills reuse agents across commands |
| Agents lack context | Skills provide project-specific context |
| Hard to maintain | Each tier has a single responsibility |

## The Three Tiers

### Tier 1: Commands (User Interface)

**Purpose:** Be the user's shortcut to get things done.

- Minimal files with YAML frontmatter
- Define arguments, flags, and usage examples
- Link to skills/agents when needed
- Can run independently for simple tasks

**File:** `commands/{category}/{action}.md`

**When to use which pattern:**
- **Pattern 1 (Command only)** — Simple bash execution (`/flutter:test`)
- **Pattern 2 (Command + Skill)** — Guided workflow (`/seo:meta`)
- **Pattern 3 (Full stack)** — Complex autonomous task (`/flutter:screen`)

### Tier 2: Skills (Orchestrator)

**Purpose:** Coordinate the workflow between user intent and agent execution.

- Analyze project context
- Prepare instructions for the agent
- Spawn the right agent with the right template
- Format and present results

**File:** `skills/{category}/{action}-{target}.md`

**When you need a skill:**
- The task has multiple steps
- Project analysis is needed before execution
- Error handling or validation is complex
- You need to coordinate multiple operations

### Tier 3: Agents (Worker)

**Purpose:** Execute tasks autonomously with specialized knowledge.

- Domain-specific expertise
- Structured workflow (analyze → plan → execute → verify)
- Standardized output format
- Defined tools and constraints

**File:** `agents/{domain}-{role}-agent.md`

**When you need an agent:**
- The task requires deep domain knowledge
- Multiple files need to be created/modified
- The work should be autonomous with minimal guidance
- Complex decision-making is involved

## Data Flow

```
User types: /flutter:screen "login"
                │
                ▼
        Command reads arguments
        "login" → screen name
                │
                ▼
        Skill analyzes project
        - Checks existing screens
        - Reads project patterns
        - Prepares instructions
                │
                ▼
        Agent executes autonomously
        - Creates widget file
        - Creates provider file
        - Updates router
        - Runs tests
                │
                ▼
        Result formatted and shown
        to the user
```

## File Map

```
.claude/
├── commands/           # Tier 1: User shortcuts
│   ├── flutter/
│   │   ├── test.md     # Pattern 1: Simple
│   │   └── screen.md   # Pattern 3: Full stack
│   └── seo/
│       └── meta.md     # Pattern 2: Command + Skill
│
├── skills/             # Tier 2: Orchestrators
│   ├── flutter/
│   │   └── create-screen.md
│   └── seo/
│       └── optimize-meta.md
│
├── agents/             # Tier 3: Workers
│   ├── flutter-dev-agent.md
│   └── seo-auditor-agent.md
│
├── persona/            # Personality definitions
│   └── nova.md
│
├── docs/               # Documentation
│   ├── architecture.md
│   └── naming-conventions.md
│
├── memory/             # Persistent context
│   └── .gitkeep
│
└── plugins/            # Plugin registry
    ├── blocklist.json
    └── known_marketplaces.json
```

## Extension Points

1. **Add a new stack** → Create `commands/{stack}/`, `skills/{stack}/`, and an agent
2. **Add a new command** → Copy `new-command-template.md` to the right category
3. **Add a new persona** → Copy `new-persona-template.md` and create a command
4. **Add a new agent** → Copy `new-agent-template.md` and reference from a skill
