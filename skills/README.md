# Skills

Skills are the orchestrator layer — they wire commands to agents and define workflows.

## What is a Skill?

A skill is a markdown file that:
- Defines a multi-step workflow
- References an agent template (for complex tasks) or handles it directly
- Specifies prerequisites, execution steps, and verification
- Provides a consistent output format

## Architecture Role

```
Command (user types /flutter:screen)
  → Skill (orchestrates the workflow)
    → Agent (executes the work autonomously)
```

Skills are the middle layer that:
1. Receives the request from a command
2. Analyzes the project context
3. Spawns an agent with the right template and instructions
4. Formats the agent's output for the user

## Creating a New Skill

1. Copy the template:
   ```bash
   cp skills/new-skill-template.md skills/[category]/[skill-name].md
   ```

2. Fill in the sections:
   - **Overview** — What it does and when to use it
   - **Trigger** — Which command activates it
   - **Agent** — Which agent template to use
   - **Workflow** — Step-by-step process
   - **Output** — Result format
   - **Examples** — Usage examples

3. Create the corresponding command:
   ```bash
   cp commands/new-command-template.md commands/[category]/[command].md
   ```

4. (If needed) Create or reference an agent:
   ```bash
   cp agents/new-agent-template.md agents/[agent-name].md
   ```

## Naming Convention

```
skills/{category}/{action}-{target}.md
```

Examples:
- `skills/flutter/create-screen.md`
- `skills/node/setup-auth.md`
- `skills/database/generate-migration.md`

## Available Skills

| Category | Skill | Agent | Description |
|----------|-------|-------|-------------|
| (Add your skills here) | | | |

## Skill Patterns

### Pattern 1: Simple (no agent)
For quick tasks that don't need an autonomous agent:
- Checklists
- Single-command execution
- Simple file generation

### Pattern 2: Full (with agent)
For complex tasks requiring autonomous work:
- Multi-file creation
- Architecture decisions
- Code generation with analysis

## Best Practices

- **One skill per workflow** — Don't combine unrelated tasks
- **Reference agents by path** — `agents/flutter-dev-agent.md`
- **Define clear triggers** — Commands and phrases that activate the skill
- **Include prerequisites** — What must exist before the skill runs
- **Handle errors** — What to do when things go wrong

## Template

See [new-skill-template.md](new-skill-template.md) for the full template.
