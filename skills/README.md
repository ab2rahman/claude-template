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
| flutter | create-screen | flutter-dev-agent | Scaffold complete Flutter screen with widget, provider, route |
| flutter | setup-provider | flutter-dev-agent | Create Riverpod provider/notifier for state management |
| flutter | setup-navigation | flutter-dev-agent | Configure GoRouter with routes, guards, and nested navigation |
| flutter | add-api-endpoint | flutter-dev-agent | Add Dio API endpoint with repository pattern |
| flutter | add-form-validation | flutter-dev-agent | Add form validation with error handling |
| kotlin | create-screen | kotlin-dev-agent | Create Jetpack Compose screen with ViewModel |
| kotlin | setup-navigation | kotlin-dev-agent | Setup Compose Navigation with type-safe routes |
| kotlin | setup-retrofit | kotlin-dev-agent | Configure Retrofit API interface with interceptors |
| kotlin | setup-room | kotlin-dev-agent | Setup Room database with entity, DAO, and migration |
| react-native | create-screen | react-native-dev-agent | Create Expo Router screen with state management |
| react-native | setup-api | react-native-dev-agent | Setup Axios API layer with interceptors |
| react-native | setup-navigation | react-native-dev-agent | Configure Expo Router with layouts and tabs |
| react-native | setup-state | react-native-dev-agent | Setup Zustand store with persist middleware |
| ios | create-screen | ios-dev-agent | Create SwiftUI screen with ViewModel |
| ios | setup-api | ios-dev-agent | Setup URLSession API client with async/await |
| ios | setup-navigation | ios-dev-agent | Configure NavigationStack with typed routes |
| node | create-route | node-dev-agent | Scaffold layered route (router, controller, service, repo) |
| node | setup-auth | node-dev-agent | Setup JWT authentication with middleware |
| node | setup-validation | node-dev-agent | Add Zod/Joi request validation to routes |
| node | setup-websocket | node-dev-agent | Integrate Socket.io real-time communication |
| nextjs | create-page | nextjs-dev-agent | Create App Router page with server components |
| nextjs | setup-api | nextjs-dev-agent | Create route handler with CRUD operations |
| nextjs | setup-auth | nextjs-dev-agent | Setup NextAuth.js v5 with providers |
| nextjs | setup-state | nextjs-dev-agent | Setup React Query for server state management |
| python | create-route | python-dev-agent | Create FastAPI router with service layer |
| python | setup-auth | python-dev-agent | Setup JWT auth with dependency injection |
| python | setup-database | python-dev-agent | Setup SQLAlchemy model with Alembic migration |
| database | design-schema | database-architect-agent | Design database schema with normalization |
| database | generate-migration | database-architect-agent | Generate reversible migration file |
| database | generate-seed | database-architect-agent | Generate seed data with faker patterns |
| devops | deploy-app | devops-engineer-agent | Deploy application to production server |
| devops | setup-docker | devops-engineer-agent | Create Dockerfile and docker-compose config |
| devops | setup-ci | devops-engineer-agent | Create GitHub Actions CI/CD workflow |
| design | analyze-image | design-analyst-agent | Extract design specs from image or Figma |
| design | figma-workflow | design-analyst-agent | Figma design-to-code workflow |
| design | implement-ui | design-analyst-agent | Implement UI from design specifications |
| seo | audit-site | seo-auditor-agent | Full SEO audit with prioritized findings |
| seo | create-content | seo-auditor-agent | Create SEO-optimized content |
| seo | optimize-performance | seo-auditor-agent | Run Lighthouse and optimize performance |
| security | audit-server | security-auditor-agent | Full server security audit |
| security | check-secrets | security-auditor-agent | Scan for hardcoded secrets and credentials |
| security | scan-dependencies | security-auditor-agent | Scan dependencies for vulnerabilities |
| security | check-headers | security-auditor-agent | Audit HTTP security headers |

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
