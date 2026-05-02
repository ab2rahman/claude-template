# File Structure

## Complete Directory Layout

```
.claude/
├── CLAUDE.md                      # Main configuration file
│
├── persona/                       # Persona definitions
│   ├── README.md
│   └── new-persona-template.md
│
├── commands/                      # Tier 1: User shortcuts
│   ├── README.md
│   ├── new-command-template.md
│   └── {category}/
│       └── {action}.md
│
├── skills/                        # Tier 2: Orchestrators
│   ├── README.md
│   ├── new-skill-template.md
│   └── {category}/
│       └── {action}-{target}.md
│
├── agents/                        # Tier 3: Workers
│   ├── README.md
│   ├── new-agent-template.md
│   └── {domain}-{role}-agent.md
│
├── docs/                          # Documentation
│   ├── README.md
│   ├── architecture.md
│   ├── naming-conventions.md
│   ├── file-structure.md
│   ├── conversion-guide.md
│   └── project-structure.md
│
├── memory/                        # Persistent context
│   └── .gitkeep
│
├── plugins/                       # Plugin registry
│   ├── blocklist.json
│   └── known_marketplaces.json
│
├── .env.template                  # Environment variables template
├── .mcp.json.template             # MCP server configuration template
├── settings.json.template         # Claude Code settings template
├── .gitignore                     # Git ignore rules
└── LICENSE                        # License file
```

## File Purposes

### Root Files

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Main instructions for Claude Code — persona, AI guidance, preferences |
| `.env.template` | Template for environment variables (copy to `.env`) |
| `.mcp.json.template` | Template for MCP server config (copy to `.mcp.json`) |
| `settings.json.template` | Template for Claude Code settings (copy to `settings.json`) |
| `.gitignore` | Prevents committing secrets and generated files |
| `LICENSE` | License for the template |

### Directories

| Directory | Purpose | Required |
|-----------|---------|----------|
| `persona/` | Define Claude's personalities | Yes |
| `commands/` | User-facing slash commands | Yes |
| `skills/` | Workflow orchestrators | Yes |
| `agents/` | Autonomous worker templates | Yes |
| `docs/` | Documentation and guides | Yes |
| `memory/` | Persistent context across sessions | Yes |
| `plugins/` | Plugin blocklist and marketplace | Yes |
| `bin/` | CLI tools and setup scripts | Optional |

## Generated Files (Not Committed)

These files are created during setup but gitignored:

| File | Source |
|------|--------|
| `.env` | Copied from `.env.template` |
| `.mcp.json` | Copied from `.mcp.json.template` |
| `settings.json` | Copied from `settings.json.template` |

## Scaling the Structure

### Adding a New Stack

```bash
# 1. Create directories
mkdir -p commands/{stack} skills/{stack}

# 2. Create agent (if needed)
cp agents/new-agent-template.md agents/{stack}-dev-agent.md

# 3. Create commands
cp commands/new-command-template.md commands/{stack}/test.md
cp commands/new-command-template.md commands/{stack}/build.md

# 4. Create skills (for complex commands)
cp skills/new-skill-template.md skills/{stack}/create-screen.md
```

### Adding a New Persona

```bash
# 1. Create persona definition
cp persona/new-persona-template.md persona/{name}.md

# 2. Create switching command
mkdir -p commands/persona
cp commands/new-command-template.md commands/persona/{name}.md
```

### Adding Project Memory

```bash
# Create memory structure for your projects
mkdir -p memory/{company}/{project}
touch memory/{company}/{project}/patterns.md
touch memory/{company}/{project}/decisions.md
touch memory/{company}/{project}/troubleshooting.md
```
