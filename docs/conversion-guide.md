# Conversion Guide

## How to Use This Template

This guide covers converting the template into your personal Claude Code setup.

### Quick Start

```bash
# 1. Clone the template
git clone <repo-url> my-claude-setup
cd my-claude-setup

# 2. Run setup (or do manually)
bash bin/claude-setup.sh init my-project

# 3. Copy templates to actual files
cp .env.template .env
cp .mcp.json.template .mcp.json
cp settings.json.template settings.json

# 4. Edit with your values
nano .env
nano .mcp.json
```

### Manual Setup

If you prefer to set up manually without the CLI script:

#### 1. Copy Template Files

```bash
cp .env.template .env          # Environment variables
cp .mcp.json.template .mcp.json  # MCP server config
cp settings.json.template settings.json  # Claude settings
```

#### 2. Fill In Your Credentials

Edit `.env` with your actual values:
- API tokens
- Project paths
- Webhook URLs
- Database URLs

#### 3. Install Components

```bash
# Using the CLI
bash bin/claude-setup.sh bundle flutter    # Install all Flutter components
bash bin/claude-setup.sh bundle node       # Install all Node.js components

# Or manually copy what you need from main branch
```

#### 4. Customize CLAUDE.md

Edit `CLAUDE.md` to match your preferences:
- Set your default persona
- Adjust AI guidance rules
- Configure task management preferences
- Set documentation-first approach

### Promoting from template/base to main

The `template/base` branch is the minimal skeleton. The `main` branch has all stacks.

```bash
# Start from base
git checkout template/base

# Create your working branch
git checkout -b main

# Add the stacks you need
bash bin/claude-setup.sh bundle flutter
bash bin/claude-setup.sh bundle node

# Commit your setup
git add .
git commit -m "Setup with Flutter and Node.js stacks"
```

### Installing to ~/.claude

To use this setup globally:

```bash
# Copy to your Claude config directory
cp -r . ~/
# or selectively:
cp CLAUDE.md ~/.claude/
cp -r commands/ ~/.claude/commands/
cp -r skills/ ~/.claude/skills/
cp -r agents/ ~/.claude/agents/
cp -r persona/ ~/.claude/persona/
```

## Migration Guide

### From a Flat ~/.claude Setup

If you have an existing flat structure:

```bash
# Old structure (flat)
~/.claude/
├── commands/
│   ├── test.md
│   ├── build.md
│   └── deploy.md        # All mixed together

# New structure (organized by stack)
~/.claude/
├── commands/
│   ├── flutter/
│   │   ├── test.md
│   │   └── build.md
│   └── devops/
│       └── deploy.md
```

**Migration steps:**
1. Categorize each command by stack
2. Create category directories
3. Move commands into the right directory
4. Update any cross-references in skill/agent files

### From Another Template System

1. Map your existing commands to the three-tier structure
2. Simple commands → Pattern 1 (command only)
3. Guided workflows → Pattern 2 (command + skill)
4. Complex tasks → Pattern 3 (command + skill + agent)
5. Copy persona definitions to `persona/`
6. Create agents for each domain specialist

## Customization Checklist

- [ ] Copy `.env.template` → `.env` and fill in values
- [ ] Copy `.mcp.json.template` → `.mcp.json` and configure servers
- [ ] Copy `settings.json.template` → `settings.json` and set preferences
- [ ] Edit `CLAUDE.md` — set default persona, adjust guidance
- [ ] Create or select a persona in `persona/`
- [ ] Install stacks you need (or copy from `main` branch)
- [ ] Set up memory directories for your projects
- [ ] Test commands with `/[category]:[action]`

## Troubleshooting

### Command not found
- Check the file exists in `commands/{category}/`
- Check the YAML frontmatter has the correct `name` field

### Agent not spawning
- Verify the skill references the correct agent path
- Check the agent template file exists in `agents/`

### Environment variables not loading
- Ensure `.env` exists (not just `.env.template`)
- Check `.zshrc` or `.bashrc` sources the `.env` file

### Settings not applying
- Ensure `settings.json` exists (not just `settings.json.template`)
- Restart Claude Code after changing settings
