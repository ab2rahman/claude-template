# Commands

Commands are user-facing slash shortcuts that trigger actions, skills, or agents.

## What is a Command?

A command is a markdown file with YAML frontmatter that:
- Provides a short, memorable slash command (e.g., `/flutter:test`)
- Defines arguments and flags
- Links to skills and agents for complex workflows
- Can run independently for simple tasks

## Using Commands

Type the slash command in Claude Code:

```
/flutter:screen "login"
/node:route "users"
/database:migrate "add_users_table"
```

## Creating a New Command

1. Copy the template:
   ```bash
   cp commands/new-command-template.md commands/[category]/[command-name].md
   ```

2. Fill in the YAML frontmatter:
   ```yaml
   ---
   name: "[category]:[command-name]"
   description: "[What this command does]"
   category: "[category]"
   ---
   ```

3. Define usage, arguments, and examples

4. Link to skill/agent if needed (Pattern 3)

## Naming Convention

```
commands/{category}/{action}.md
```

Examples:
- `commands/flutter/test.md` → `/flutter:test`
- `commands/node/route.md` → `/node:route`
- `commands/devops/deploy.md` → `/devops:deploy`

## Three Patterns

### Pattern 1: Simple Command
Just runs bash commands. No skill or agent.

```
/flutter:test  →  Runs flutter test directly
```

### Pattern 2: Command + Skill
Guided workflow without an autonomous agent.

```
/seo:meta  →  skill:seo/optimize-meta  →  Checklist + edits
```

### Pattern 3: Full Three-Tier
Command triggers skill, which spawns an agent.

```
/flutter:screen  →  skill:flutter/create-screen  →  agent:flutter-dev-agent
```

## Available Commands

| Category | Command | Pattern | Description |
|----------|---------|---------|-------------|
| (Add your commands here) | | | |

## Organization

Commands are organized by tech stack:

```
commands/
├── persona/        # Persona switching
├── flutter/        # Flutter/Dart
├── kotlin/         # Kotlin/Android
├── react-native/   # React Native
├── ios/            # iOS/Swift
├── node/           # Node.js/Express
├── nextjs/         # Next.js/React
├── python/         # Python/FastAPI
├── database/       # Database/SQL
├── devops/         # DevOps/Deploy
├── design/         # Design UI/Figma
├── seo/            # SEO/Content
└── security/       # Security/Audit
```

## Template

See [new-command-template.md](new-command-template.md) for the full template.
