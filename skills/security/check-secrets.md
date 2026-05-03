---
name: "Check Secrets"
description: "Scans codebase and git history for leaked secrets, API keys, tokens, and credentials."
category: "security"
---

# Check Secrets

## Overview

Scans the entire codebase including git history for accidentally committed secrets, API keys, tokens, passwords, and other sensitive credentials. Checks configuration files, source code, environment files, and commit history for leaked secrets that need to be rotated.

## Trigger

This skill is triggered by:
- Command: `/security:secrets`
- Direct request: "check for leaked secrets", "scan for API keys", "find exposed credentials"

## Prerequisites

- Access to the git repository
- Git history available (not a shallow clone)
- Recommended: gitleaks or trufflehog installed (falls back to pattern matching)

## Agent

**Template:** `agents/security-auditor-agent.md`

Spawns a security-auditor agent to perform the secret leak detection scan.

## Workflow

### Step 1: Analyze

- Detect available scanning tools (gitleaks, trufflehog, detect-secrets)
- Define secret patterns to scan for:
  - API keys (AWS, GCP, Stripe, GitHub, etc.)
  - Database connection strings
  - JWT secrets and tokens
  - Private keys (SSH, PGP, certificates)
  - Hardcoded passwords and credentials
- Identify file types to prioritize (.env, config.*, *.yaml, *.json, source files)

### Step 2: Plan

- Scan current working tree for secret patterns
- Scan full git history including all branches
- Check common secret locations: .env files, config directories, CI/CD files
- Plan remediation for each finding

### Step 3: Execute

- Run pattern-based scan across all files in the working directory
- Run git history scan for secrets in past commits
- Check for .env files that are not in .gitignore
- Scan CI/CD configuration for hardcoded secrets
- Generate a report with each finding: file, line, secret type, severity

### Step 4: Verify

- Confirm each finding is an actual secret (reduce false positives)
- Check if identified secrets are still active (test endpoints if safe)
- Verify .gitignore covers sensitive file patterns
- Ensure remediation steps are practical (rotate key, remove from history)

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  CHECK SECRETS — COMPLETE         ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • docs/secrets-audit-report.md    ║
║                                    ║
║  Findings:                         ║
║  • Active secrets in code: [count] ║
║  • Secrets in git history: [count] ║
║  • Exposed .env files: [count]     ║
║                                    ║
║  Critical findings:                ║
║  • [file:line] — [secret type]     ║
║  • [file:line] — [secret type]     ║
║                                    ║
║  Remediation:                      ║
║  • Rotate compromised keys         ║
║  • Add patterns to .gitignore      ║
║  • Use git-filter-repo to clean    ║
║                                    ║
║  Next steps:                       ║
║  • Rotate ALL found secrets        ║
║  • Clean git history if needed     ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Full Scan

```
/security:secrets
```

Expected result: Complete scan of working tree and git history with all secret findings.

### Example 2: History Only

```
/security:secrets --history-only --depth=100
```

Expected result: Scan only the last 100 commits in git history for leaked secrets.

## Error Handling

- **No git history:** Scan only the working tree and warn about limited scope
- **Tool not installed:** Fall back to grep-based pattern matching with regex
- **False positives:** Allow user to mark findings as false positives and re-scan
- **Large repo:** Limit scan depth and suggest targeted scan by directory
