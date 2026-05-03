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
| persona | /persona:nova | 1 | Switch to Nova (Precision Engineer) persona |
| persona | /persona:blaze | 1 | Switch to Blaze (Creative Partner) persona |
| flutter | /flutter:test | 1 | Run Flutter tests |
| flutter | /flutter:build | 1 | Build Flutter app |
| flutter | /flutter:clean | 1 | Clean Flutter build |
| flutter | /flutter:coverage | 1 | Generate test coverage |
| flutter | /flutter:lint | 1 | Run Dart linter |
| flutter | /flutter:screen | 3 | Create new Flutter screen |
| flutter | /flutter:provider | 2 | Create Riverpod provider |
| flutter | /flutter:nav | 2 | Setup GoRouter navigation |
| flutter | /flutter:api | 2 | Add Dio API endpoint |
| flutter | /flutter:form | 2 | Add form validation |
| flutter | /flutter:widget-test | 2 | Generate widget test |
| kotlin | /kotlin:build | 1 | Build Kotlin project |
| kotlin | /kotlin:test | 1 | Run Kotlin tests |
| kotlin | /kotlin:lint | 1 | Run Kotlin linter |
| kotlin | /kotlin:screen | 3 | Create Compose screen |
| kotlin | /kotlin:viewmodel | 2 | Create ViewModel |
| kotlin | /kotlin:api | 2 | Setup Retrofit API |
| kotlin | /kotlin:nav | 2 | Setup navigation |
| kotlin | /kotlin:room | 2 | Setup Room database |
| react-native | /react-native:build | 1 | Build React Native app |
| react-native | /react-native:test | 1 | Run React Native tests |
| react-native | /react-native:lint | 1 | Run ESLint |
| react-native | /react-native:screen | 3 | Create new screen |
| react-native | /react-native:component | 2 | Create reusable component |
| react-native | /react-native:api | 2 | Setup API layer |
| react-native | /react-native:nav | 2 | Setup navigation |
| react-native | /react-native:state | 2 | Setup state management |
| ios | /ios:build | 1 | Build iOS project |
| ios | /ios:test | 1 | Run Swift tests |
| ios | /ios:screen | 3 | Create SwiftUI screen |
| ios | /ios:viewmodel | 2 | Create ObservableObject ViewModel |
| ios | /ios:api | 2 | Setup URLSession API |
| ios | /ios:nav | 2 | Setup NavigationStack |
| ios | /ios:coredata | 2 | Setup Core Data entity |
| node | /node:build | 1 | Build Node.js project |
| node | /node:test | 1 | Run Node.js tests |
| node | /node:lint | 1 | Run ESLint |
| node | /node:route | 3 | Create layered route |
| node | /node:middleware | 2 | Create Express middleware |
| node | /node:model | 2 | Create data model |
| node | /node:api-docs | 2 | Generate API documentation |
| nextjs | /nextjs:build | 1 | Build Next.js project |
| nextjs | /nextjs:test | 1 | Run Next.js tests |
| nextjs | /nextjs:lint | 1 | Run ESLint |
| nextjs | /nextjs:page | 3 | Create App Router page |
| nextjs | /nextjs:component | 2 | Create React component |
| nextjs | /nextjs:api | 2 | Create API route handler |
| nextjs | /nextjs:layout | 2 | Create layout template |
| nextjs | /nextjs:state | 2 | Setup state management |
| python | /python:build | 1 | Install and check Python project |
| python | /python:test | 1 | Run pytest |
| python | /python:lint | 1 | Run ruff linter |
| python | /python:route | 3 | Create FastAPI route |
| python | /python:auth | 2 | Setup JWT authentication |
| python | /python:model | 2 | Create SQLAlchemy model |
| database | /database:query | 1 | Run SQL query |
| database | /database:schema | 3 | Design database schema |
| database | /database:migrate | 2 | Generate migration |
| database | /database:seed | 2 | Generate seed data |
| database | /database:erd | 2 | Generate ER diagram |
| devops | /devops:deploy | 3 | Deploy application |
| devops | /devops:docker | 2 | Setup Docker config |
| devops | /devops:ci | 2 | Setup CI/CD pipeline |
| devops | /devops:env | 2 | Setup environment config |
| devops | /devops:monitor | 2 | Setup monitoring |
| design | /design:analyze | 2 | Analyze design image |
| design | /design:figma | 2 | Figma integration workflow |
| design | /design:implement | 2 | Implement UI from design |
| design | /design:theme | 2 | Create theme and tokens |
| seo | /seo:audit | 3 | Full SEO audit |
| seo | /seo:content | 2 | Create SEO content |
| seo | /seo:meta | 2 | Generate meta tags |
| seo | /seo:lighthouse | 1 | Run Lighthouse audit |
| security | /security:audit | 3 | Full security audit |
| security | /security:headers | 2 | Check security headers |
| security | /security:deps | 2 | Scan dependencies |
| security | /security:secrets | 2 | Check for exposed secrets |

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
