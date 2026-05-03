---
name: "Scan Dependencies"
description: "Scans project dependencies for known vulnerabilities and suggests fixes with version bumps."
category: "security"
---

# Scan Dependencies

## Overview

Scans project dependencies for known vulnerabilities using the appropriate audit tool for the package manager. Analyzes each vulnerability by severity, identifies the fix (version bump or alternative package), and generates an actionable report.

## Trigger

This skill is triggered by:
- Command: `/security:deps`
- Direct request: "scan for vulnerable dependencies", "check dependencies for CVEs", "audit packages"

## Prerequisites

- Project with a lock file or dependency manifest (package-lock.json, yarn.lock, Pipfile, go.sum, etc.)
- Package manager CLI available (npm, yarn, pip, pipenv, cargo, etc.)

## Agent

**Template:** `agents/security-auditor-agent.md`

Spawns a security-auditor agent to run the vulnerability scan and analyze results.

## Workflow

### Step 1: Analyze

- Detect the package manager from lock files and manifest files
- Identify all direct and transitive dependencies
- Run the appropriate audit command:
  - npm: `npm audit`
  - yarn: `yarn audit`
  - pip: `pip audit` or `safety check`
  - go: `govulncheck`
  - cargo: `cargo audit`

### Step 2: Plan

- Parse audit output and categorize by severity (critical, high, moderate, low)
- For each vulnerability, identify the CVE and affected versions
- Determine if a direct fix is available (version bump) or if a workaround is needed
- Check for breaking changes in the fix version

### Step 3: Execute

- Generate the vulnerability report with CVE references
- For each vulnerability, suggest the specific version to update to
- Flag dependencies with no available fix (recommend alternatives or pinning)
- Create a summary of safe-to-update patches vs. major version bumps

### Step 4: Verify

- Confirm each CVE reference is valid and up-to-date
- Ensure suggested fix versions actually exist in the registry
- Check that suggested updates won't introduce new vulnerabilities
- Validate the report against the actual audit output

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  SCAN DEPENDENCIES — COMPLETE     ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • docs/dependency-audit-report.md ║
║                                    ║
║  Total dependencies: [count]       ║
║  Vulnerabilities found:            ║
║  • Critical: [count]               ║
║  • High: [count]                   ║
║  • Moderate: [count]               ║
║  • Low: [count]                    ║
║                                    ║
║  Quick fix:                        ║
║  • [package] → update to [version] ║
║  • [package] → update to [version] ║
║                                    ║
║  Next steps:                       ║
║  • Apply critical fixes first      ║
║  • Run tests after each update     ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Full Scan

```
/security:deps
```

Expected result: Complete dependency audit with all vulnerabilities and fix suggestions.

### Example 2: Fix Mode

```
/security:deps --fix --severity=high,critical
```

Expected result: Auto-fix critical and high severity vulnerabilities and report what was updated.

## Error Handling

- **No lock file found:** Prompt user to run install first and generate lock file
- **Audit tool not installed:** Suggest installation command for the audit tool
- **Fix introduces breaking changes:** Flag in report and recommend manual review
