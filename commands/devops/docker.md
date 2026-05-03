---
name: "devops:docker"
description: "Create Dockerfile and docker-compose configuration"
category: "devops"
---

# /devops:docker

Generate Dockerfile and docker-compose.yml for the specified service.

## Usage

```bash
/devops:docker "[service-name]"
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[service-name]` | Yes | Name of the service to containerize |

## Examples

### API Service
```bash
/devops:docker "api"
```

### Full Stack
```bash
/devops:docker "web-app" --fullstack
```

## What It Does

1. Analyzes project structure and technology stack
2. Generates optimized Dockerfile with multi-stage build
3. Creates docker-compose.yml with service definitions
4. Adds .dockerignore for efficient builds
5. Configures health checks and environment variables

## Connected Components


- **Skill:** `skill:devops/setup-docker`
- **Agent:** `agent:devops-engineer-agent`

## Notes

- Detects language/framework and uses appropriate base image
- Includes development and production configurations
- Supports multi-service architectures with networking
