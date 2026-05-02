# Agents

Agents are autonomous workers that execute complex tasks. They're the execution layer of the three-tier architecture.

## What is an Agent?

An agent is a markdown file that defines a specialized AI worker with:
- A specific identity and expertise
- A structured workflow
- Defined tools and constraints
- A standard output format

## Architecture

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

## Creating a New Agent

1. Copy the template:
   ```bash
   cp agents/new-agent-template.md agents/your-agent.md
   ```

2. Define the agent:
   - **Identity** — Name, specialty, seniority level
   - **Core Expertise** — 4-6 areas of deep knowledge
   - **Workflow** — Step-by-step process for tasks
   - **Output Format** — How results are reported
   - **Constraints** — What the agent should/shouldn't do

3. Reference from a skill:
   ```markdown
   Agent: agents/your-agent.md
   ```

## Naming Convention

```
{domain}-{role}-agent.md
```

Examples:
- `flutter-dev-agent.md`
- `database-architect-agent.md`
- `security-auditor-agent.md`

## Available Agents

| Agent | Specialty | Invoked By |
|-------|-----------|------------|
| (Add your agents here) | | |

## Best Practices

- **One domain per agent** — Don't create a "does everything" agent
- **Be specific about expertise** — "Flutter with Riverpod and GoRouter" > "Mobile dev"
- **Define clear workflows** — Agents work best with structured steps
- **Keep output format consistent** — Use the standard boxed format
- **List all tools** — Agents only use tools you explicitly list

## Template

See [new-agent-template.md](new-agent-template.md) for the full template.
