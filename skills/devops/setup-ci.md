---
name: "Setup CI"
description: "Creates GitHub Actions CI/CD pipeline with build, test, and deploy stages."
category: "devops"
---

# Setup CI

## Overview

Creates a complete GitHub Actions workflow YAML file with build, test, and deploy stages tailored to the project's language, framework, and deployment target.

## Trigger

This skill is triggered by:
- Command: `/devops:ci`
- Direct request: "setup CI", "create GitHub Actions pipeline", "add CI/CD"

## Prerequisites

- Git repository hosted on GitHub
- Project with test suite configured
- Deployment target identified (AWS, GCP, Vercel, Railway, etc.)

## Agent

**Template:** `agents/devops-engineer-agent.md`

Spawns a devops-engineer agent to design and create the pipeline configuration.

## Workflow

### Step 1: Analyze

- Detect project language, framework, and package manager
- Identify the test runner and test commands from package.json or equivalent
- Determine the build process (compile, bundle, etc.)
- Check for existing `.github/workflows/` directory

### Step 2: Plan

- Define pipeline stages: lint, test, build, deploy
- Select appropriate GitHub Actions runners (ubuntu-latest, etc.)
- Plan caching strategy for dependencies
- Identify required secrets and environment variables
- Configure branch triggers (push to main, pull requests)

### Step 3: Execute

- Create `.github/workflows/ci.yml` with the full pipeline
- Configure build stage with dependency caching
- Add test stage with coverage reporting
- Add deploy stage gated on branch and test success
- Document required GitHub secrets in the workflow comments

### Step 4: Verify

- Validate YAML syntax
- Confirm all referenced actions exist (actions/checkout, actions/setup-node, etc.)
- Check that environment variables reference secrets correctly
- Ensure deploy stage only triggers on the correct branch

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  SETUP CI — COMPLETE              ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • .github/workflows/ci.yml        ║
║                                    ║
║  Stages: lint, test, build, deploy ║
║  Trigger: push to main, PRs        ║
║                                    ║
║  Required secrets:                 ║
║  • DEPLOY_KEY                      ║
║  • [other secrets]                 ║
║                                    ║
║  Next steps:                       ║
║  • Add secrets to GitHub repo      ║
║  • Push to trigger first run       ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Node.js + Deploy

```
/devops:ci
```

Expected result: CI pipeline with lint, test, build, and deploy to configured target.

### Example 2: Multi-Environment

```
/devops:ci --staging --production --env-vars
```

Expected result: Pipeline with separate staging and production deploy stages with environment protection.

## Error Handling

- **No test suite found:** Create a placeholder test step and warn user
- **Missing deployment config:** Generate deploy stage with TODO comments
- **Invalid YAML:** Validate with a YAML linter and fix indentation issues
