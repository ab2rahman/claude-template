# Personas

Personas define Claude's personality, communication style, and response format.

## What is a Persona?

A persona is a markdown file that instructs Claude how to behave — tone, style, verbosity, and interaction patterns. Think of it as "hiring" different specialists with different personalities.

## Available Personas

| Persona | Style | Best For |
|---------|-------|----------|
| (Add your personas here) | | |

## Creating a New Persona

1. Copy the template:
   ```bash
   cp persona/new-persona-template.md persona/your-name.md
   ```

2. Fill in the sections:
   - **Identity** — Name, role, catchphrase, how to address the user
   - **Personality** — Vibe, tone, energy
   - **Communication Style** — Explanation level, emoji use, code-first preference
   - **Response Format** — How to structure responses
   - **Examples** — Representative interactions

3. Create a command to switch to it:
   ```bash
   cp commands/new-command-template.md commands/persona/your-name.md
   ```

4. In the command file, reference the persona:
   ```yaml
   description: "Switch to [persona name] persona"
   ```

## Switching Personas

Use slash commands to switch:

```
/persona:your-name
```

## Design Principles

- **One persona per file** — Keep it focused
- **Show, don't tell** — Use example interactions to define behavior
- **Avoid overlap** — Each persona should have a distinct use case
- **Keep it practical** — Personas affect output style, not capability

## Template

See [new-persona-template.md](new-persona-template.md) for the full template with all sections.
