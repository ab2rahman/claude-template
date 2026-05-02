# Claude Code Template System

Main configuration file for Claude Code. Customize this to match your workflow.

**Last Updated:** 2026-05-02

---

## Persona System

**Default Persona:** (Set your default here)

Available personas are in `persona/`. Switch using:
```
/persona:[name]
```

See [persona/README.md](persona/README.md) for details.

---

## AI Guidance

- NEVER give explanation without being asked
- NEVER show how you think unless asked, only result matters
- ALWAYS read and understand relevant files before proposing code edits
- Do not speculate about code you have not inspected
- After completing a task, provide a quick summary
- For maximum efficiency, invoke independent operations in parallel
- Before finishing, verify your solution
- Do what has been asked; nothing more, nothing less
- NEVER create files unless absolutely necessary
- ALWAYS prefer editing an existing file to creating a new one
- NEVER proactively create documentation files unless explicitly requested

---

## Task Management

For complex multi-step tasks, use TaskCreate to track progress.

**When to create tasks:**
- Task involves 3+ distinct steps
- Complex tasks requiring planning
- User explicitly requests a todo list

**How to use tasks:**
1. Create tasks with `subject`, `description`, `activeForm`
2. Mark as `in_progress` when starting
3. Mark as `completed` when done
4. Work in ID order (lowest first)

---

## Planning Workflow

**Use EnterPlanMode when:**
- Task involves 3+ files to modify
- Multiple valid approaches exist
- Architecture decisions needed

**Skip planning for:**
- Single-line fixes
- Tasks with specific, detailed instructions
- Pure research tasks

---

## Three-Tier Command Architecture

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

**Patterns:**
- **Pattern 1:** Command only (simple bash)
- **Pattern 2:** Command + Skill (guided workflow)
- **Pattern 3:** Command + Skill + Agent (autonomous task)

See [docs/architecture.md](docs/architecture.md) for full details.

---

## Memory Bank

Check `memory/` for persistent context across sessions.

Organize by client/project:
```
memory/
├── {company}/
│   └── {project}/
│       ├── patterns.md
│       ├── decisions.md
│       └── troubleshooting.md
└── shared/
```

---

## Environment Setup

```bash
cp .env.template .env          # Edit with your credentials
cp .mcp.json.template .mcp.json  # Configure MCP servers
cp settings.json.template settings.json  # Claude settings
```

**Rules:**
- NEVER hardcode credentials in committed files
- ALWAYS use `${VARIABLE_NAME}` format
- Never commit `.env`, `.mcp.json`, or `settings.json`

---

## Documentation

**Check docs BEFORE exploring code:**

1. [docs/architecture.md](docs/architecture.md) — System architecture
2. [docs/naming-conventions.md](docs/naming-conventions.md) — Naming rules
3. [docs/file-structure.md](docs/file-structure.md) — Directory layout
4. [docs/conversion-guide.md](docs/conversion-guide.md) — Setup guide
5. [docs/project-structure.md](docs/project-structure.md) — Project organization

---

## Response Format

Use a mix of styles based on content:

| Style | Use For | Example |
|-------|---------|---------|
| Box borders | Results, summaries | `╔═══ RESULTS ══╗` |
| Dividers | Steps, breakdowns | `── Phase 1 ──` |
| Tables | Comparisons | `| File | Status |` |

---

## File Organization

```
.claude/
├── persona/       # Personality definitions
├── commands/      # User shortcuts (Tier 1)
├── skills/        # Orchestrators (Tier 2)
├── agents/        # Workers (Tier 3)
├── docs/          # Documentation
├── memory/        # Persistent context
├── plugins/       # Plugin registry
└── bin/           # CLI tools
```

**Rule of thumb:** Keep root clean. Everything goes in the right directory.

---

*For project-specific configurations, add a CLAUDE.md in your project root.*
