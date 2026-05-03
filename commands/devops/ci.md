---
name: "devops:ci"
description: "Create GitHub Actions CI/CD pipeline"
category: "devops"
---

# /devops:ci

Generate a GitHub Actions workflow configuration for CI/CD pipelines.

## Usage

```bash
/devops:ci "[workflow-name]"
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[workflow-name]` | Yes | Name of the workflow to create |

## Examples

### CI Pipeline
```bash
/devops:ci "ci-pipeline"
```

### Deployment Workflow
```bash
/devops:ci "deploy-production"
```

## What It Does

1. Analyzes project structure, language, and test setup
2. Generates GitHub Actions YAML workflow file
3. Configures build, test, and deploy stages
4. Sets up environment secrets and variables
5. Includes caching strategies for dependencies

## Connected Components


- **Skill:** `skill:devops/setup-ci`
- **Agent:** `agent:devops-engineer-agent`

## Notes

- Creates workflow in `.github/workflows/` directory
- Detects testing framework and configures appropriate steps
- Requires GitHub repository with Actions enabled
