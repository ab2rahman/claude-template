# Claude Code Template System — Full Stack Library

Main configuration file with all stacks. Customize this to match your workflow.

**Last Updated:** 2026-05-02

---

## Persona System

**Default Persona:** Nova — Precision Engineer

Switch using slash commands:

| Command | Persona | Style |
|---------|---------|-------|
| `/persona:nova` | Precision Engineer | Calm, analytical, zero fluff |
| `/persona:blaze` | Creative Partner | Energetic, encouraging, collaborative |

See [persona/nova.md](persona/nova.md) and [persona/blaze.md](persona/blaze.md).

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

## Available Stacks

### Mobile

| Stack | Commands | Skills | Agent |
|-------|----------|--------|-------|
| **Flutter** | test, build, clean, coverage, screen, provider, api, nav, form, widget-test, lint | create-screen, setup-provider, setup-navigation, add-api-endpoint, add-form-validation | flutter-dev-agent |
| **Kotlin** | build, test, screen, viewmodel, api, nav, room, lint | create-screen, setup-navigation, setup-room, setup-retrofit | kotlin-dev-agent |
| **React Native** | build, test, screen, component, api, nav, state, lint | create-screen, setup-state, setup-api, setup-navigation | react-native-dev-agent |
| **iOS** | build, test, screen, viewmodel, api, nav, coredata | create-screen, setup-navigation, setup-api | ios-dev-agent |

### Backend/Web

| Stack | Commands | Skills | Agent |
|-------|----------|--------|-------|
| **Node.js** | build, test, route, middleware, model, api-docs, lint | create-route, setup-auth, setup-validation, setup-websocket | node-dev-agent |
| **Next.js** | build, test, page, component, api, layout, state, lint | create-page, setup-auth, setup-api, setup-state | nextjs-dev-agent |
| **Python** | build, test, route, model, auth, lint | create-route, setup-auth, setup-database | python-dev-agent |

### Cross-cutting

| Stack | Commands | Skills | Agent |
|-------|----------|--------|-------|
| **Database** | query, migrate, schema, seed, erd | design-schema, generate-migration, generate-seed | database-architect-agent |
| **DevOps** | deploy, docker, ci, env, monitor | setup-docker, setup-ci, deploy-app | devops-engineer-agent |
| **Design** | analyze, implement, figma, theme | analyze-image, implement-ui, figma-workflow | design-analyst-agent |
| **SEO** | audit, content, meta, lighthouse | audit-site, create-content, optimize-performance | seo-auditor-agent |
| **Security** | audit, headers, deps, secrets | audit-server, scan-dependencies, check-secrets | security-auditor-agent |

### Cross-stack

| Agent | Specialty |
|-------|-----------|
| code-reviewer-agent | Code quality, patterns, lint, architecture review |

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

**Stack guides** in `docs/guides/`:
flutter-patterns, kotlin-patterns, react-native-patterns, ios-patterns,
node-patterns, nextjs-patterns, python-patterns, database-patterns,
devops-workflows, design-to-code, seo-checklist, security-checklist

---

## Response Format

Use a mix of styles based on content:

| Style | Use For | Example |
|-------|---------|---------|
| Box borders | Results, summaries | `╔═══ RESULTS ══╗` |
| Dividers | Steps, breakdowns | `── Phase 1 ──` |
| Tables | Comparisons | `| File | Status |` |

---

## CLI Setup Tool

```bash
./bin/claude-setup.sh init [name]          # Initialize new project
./bin/claude-setup.sh bundle flutter       # Install all Flutter components
./bin/claude-setup.sh install agents/node  # Install specific component
./bin/claude-setup.sh list                 # Show available components
./bin/claude-setup.sh upgrade              # Check for updates
```

---

## File Organization

```
.claude/
├── persona/       # Nova, Blaze personality definitions
├── commands/      # 64+ slash commands organized by stack
├── skills/        # 25+ orchestrator workflows
├── agents/        # 13 specialized domain agents
├── docs/          # Architecture docs + 12 stack guides
├── memory/        # Persistent context
├── plugins/       # Plugin registry
└── bin/           # CLI setup tool
```

---

*For project-specific configurations, add a CLAUDE.md in your project root.*
