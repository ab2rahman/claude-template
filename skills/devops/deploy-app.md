---
name: "Deploy App"
description: "Executes deployment workflow: build, test, deploy, health check, and rollback plan."
category: "devops"
---

# Deploy App

## Overview

Executes a full deployment workflow: verifies the environment, builds the application, runs tests, deploys to the target environment, performs health checks, and prepares a rollback plan.

## Trigger

This skill is triggered by:
- Command: `/devops:deploy`
- Direct request: "deploy the app", "deploy to staging", "deploy to production"

## Prerequisites

- Deployment target configured (server, cloud provider, platform)
- Environment variables set for the target environment
- CI/CD pipeline or deployment scripts available
- SSH keys or API tokens configured for the deployment target

## Agent

**Template:** `agents/devops-engineer-agent.md`

Spawns a devops-engineer agent to execute the deployment workflow safely.

## Workflow

### Step 1: Analyze

- Verify the target environment (staging, production)
- Confirm all required environment variables are set
- Check current deployment status and last known good state
- Identify the deployment method (SSH, CLI, API, etc.)

### Step 2: Plan

- Record the current deployment version for rollback
- Define the deployment steps specific to the platform
- Set up health check endpoints and expected responses
- Prepare rollback commands in case of failure

### Step 3: Execute

- Run the build command for the target environment
- Execute the test suite and confirm all tests pass
- Deploy the build to the target environment
- Run database migrations if applicable
- Warm up caches and clear CDN if needed

### Step 4: Verify

- Hit the health check endpoint and confirm 200 OK
- Verify the deployed version matches the intended version
- Check error rates in logs for anomalies
- Confirm rollback plan is documented and tested

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  DEPLOY APP — COMPLETE            ║
╠════════════════════════════════════╣
║                                    ║
║  Environment: [staging/production] ║
║  Version: [commit hash or tag]     ║
║  URL: [deployed URL]               ║
║                                    ║
║  Health check: PASS                ║
║  Migrations: [applied/none]        ║
║                                    ║
║  Rollback plan:                    ║
║  • [rollback command]              ║
║                                    ║
║  Next steps:                       ║
║  • Monitor logs for 15 minutes     ║
║  • Verify critical user flows      ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Deploy to Staging

```
/devops:deploy --env=staging
```

Expected result: Build, test, deploy to staging, health check passes, rollback plan documented.

### Example 2: Deploy to Production

```
/devops:deploy --env=production --migrate --rollback-safe
```

Expected result: Production deployment with database migrations and verified rollback capability.

## Error Handling

- **Tests fail:** Abort deployment, report failing tests, do not proceed
- **Health check fails:** Execute automatic rollback to previous version
- **Migration error:** Rollback migration and deployment, notify team
