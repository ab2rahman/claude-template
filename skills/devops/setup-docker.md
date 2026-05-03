---
name: "Setup Docker"
description: "Creates Dockerfile with multi-stage builds and docker-compose.yml for the project."
category: "devops"
---

# Setup Docker

## Overview

Creates production-ready Docker configuration for the project including a multi-stage Dockerfile, docker-compose.yml for local development, and a .dockerignore file. Adapts to the project's language, framework, and dependencies.

## Trigger

This skill is triggered by:
- Command: `/devops:docker`
- Direct request: "dockerize this app", "setup docker", "create dockerfile and compose"

## Prerequisites

- Project with a defined language/framework (detected automatically)
- Package manager and dependency files present (package.json, requirements.txt, go.mod, etc.)
- No existing Dockerfile (or user requests overwrite)

## Agent

**Template:** `agents/devops-engineer-agent.md`

Spawns a devops-engineer agent to analyze the project and generate Docker configuration.

## Workflow

### Step 1: Analyze

- Detect project language, framework, and runtime version
- Identify build dependencies and runtime dependencies
- Check for existing Docker or container configuration
- Determine the app's entry point and required environment variables

### Step 2: Plan

- Select appropriate base images for build and runtime stages
- Determine build steps (install, compile, build static assets)
- Identify files to exclude via .dockerignore
- Plan service dependencies for docker-compose (database, redis, etc.)

### Step 3: Execute

- Create `Dockerfile` with multi-stage build (builder + production)
- Create `docker-compose.yml` with app service and dependencies
- Create `.dockerignore` excluding node_modules, .git, .env, etc.
- Add volume mounts for development hot-reload where applicable
- Configure health checks in compose file

### Step 4: Verify

- Run `docker build` to confirm the image builds successfully
- Run `docker-compose up` to verify services start correctly
- Check image size is reasonable for the framework
- Confirm environment variables are properly passed

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  SETUP DOCKER — COMPLETE          ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • Dockerfile                      ║
║  • docker-compose.yml              ║
║  • .dockerignore                   ║
║                                    ║
║  Image size: ~[size]MB             ║
║  Services: [list]                  ║
║                                    ║
║  Next steps:                       ║
║  • docker-compose up --build       ║
║  • Review exposed ports            ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Node.js App

```
/devops:docker
```

Expected result: Multi-stage Node.js Dockerfile, compose with app + MongoDB.

### Example 2: With Database

```
/devops:docker --services=postgres,redis
```

Expected result: Dockerfile plus compose with app, PostgreSQL, and Redis services.

## Error Handling

- **Unknown framework:** Ask user to specify base image and build commands
- **Build fails:** Check dependency installation, fix layer ordering, suggest cache optimizations
- **Port conflict:** Suggest alternative ports and update compose accordingly
