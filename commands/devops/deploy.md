---
name: "devops:deploy"
description: "Deploy application to specified environment"
category: "devops"
---

# /devops:deploy

Deploy the application to the target environment with validation and rollback support.

## Usage

```bash
/devops:deploy "[environment]"
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[environment]` | Yes | Target environment: staging or production |

## Examples

### Deploy to Staging
```bash
/devops:deploy "staging"
```

### Deploy to Production
```bash
/devops:deploy "production"
```

## What It Does

1. Validates environment configuration and credentials
2. Runs pre-deployment checks (tests, lint, build)
3. Builds and tags Docker images or build artifacts
4. Deploys to the target environment via configured method
5. Runs post-deployment health checks and smoke tests
6. Provides rollback instructions if deployment fails

## Connected Components


- **Skill:** `skill:devops/deploy-app`
- **Agent:** `agent:devops-engineer-agent`

## Notes

- Requires deployment configuration in project
- Production deployments may require additional approval
- Always creates a rollback snapshot before deploying
