# Naming Conventions

## Overview

Consistent naming makes the template system predictable and searchable.

## File Naming

### Commands
```
commands/{category}/{action}.md
```
- **Category:** lowercase, hyphenated (`react-native`, `nextjs`)
- **Action:** single word, lowercase (`test`, `build`, `screen`, `route`)
- Examples: `commands/flutter/test.md`, `commands/node/route.md`

### Skills
```
skills/{category}/{action}-{target}.md
```
- **Category:** matches command category exactly
- **Action-target:** describes what the skill does
- Examples: `skills/flutter/create-screen.md`, `skills/node/setup-auth.md`

### Agents
```
agents/{domain}-{role}-agent.md
```
- **Domain:** tech stack or specialty area
- **Role:** what kind of specialist
- Examples: `agents/flutter-dev-agent.md`, `agents/security-auditor-agent.md`

### Personas
```
persona/{name}.md
```
- **Name:** single word, lowercase
- Examples: `persona/nova.md`, `persona/blaze.md`

### Commands for Personas
```
commands/persona/{name}.md
```
- Matches persona name exactly
- Examples: `commands/persona/nova.md`, `commands/persona/blaze.md`

### Documentation
```
docs/{type}/{subject}.md
```
- **Type:** `guides/` for tutorials, root for reference
- **Subject:** descriptive, hyphenated
- Examples: `docs/architecture.md`, `docs/guides/flutter-patterns.md`

### Memory
```
memory/{client}/{project}/{type}.md
```
- **Type:** `patterns.md`, `decisions.md`, `troubleshooting.md`
- Examples: `memory/company-a/project-x/patterns.md`

## Category Names

| Category | Tech Stack | Command Prefix |
|----------|-----------|----------------|
| `flutter` | Flutter/Dart | `/flutter:` |
| `kotlin` | Kotlin/Android | `/kotlin:` |
| `react-native` | React Native/TypeScript | `/react-native:` |
| `ios` | iOS/Swift/SwiftUI | `/ios:` |
| `node` | Node.js/Express | `/node:` |
| `nextjs` | Next.js/React | `/nextjs:` |
| `python` | Python/FastAPI | `/python:` |
| `database` | SQL/NoSQL | `/database:` |
| `devops` | Docker/CI/CD | `/devops:` |
| `design` | Figma/UI/UX | `/design:` |
| `seo` | SEO/Content | `/seo:` |
| `security` | Security/Audit | `/security:` |
| `persona` | Persona switching | `/persona:` |

## Content Conventions

### YAML Frontmatter (Commands)
```yaml
---
name: "category:action"
description: "Brief description"
category: "category"
---
```

### Section Headers
- Use `##` for major sections
- Use `###` for subsections
- Keep headers descriptive and consistent

### Tables
Use markdown tables for structured data:
```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Data     | Data     | Data     |
```

### Code Examples
- Use fenced code blocks with language hints
- Include comments for complex logic
- Show realistic, runnable examples

## Anti-Patterns

Avoid:
- ❌ `commands/flutter/CreateScreen.md` (PascalCase in filenames)
- ❌ `agents/flutter_agent.md` (underscore instead of hyphen)
- ❌ `skills/flutter/createScreen.md` (camelCase in filenames)
- ❌ `persona/my-persona-v2.md` (versioning in filenames)
- ❌ `docs/doc1.md` (non-descriptive names)

## Template Files

Template files use the `new-*-template.md` pattern:
- `commands/new-command-template.md`
- `skills/new-skill-template.md`
- `agents/new-agent-template.md`
- `persona/new-persona-template.md`
