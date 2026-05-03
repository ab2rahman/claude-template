---
name: "security:secrets"
description: "Detect leaked secrets — API keys, tokens, passwords in codebase"
category: "security"
---

# /security:secrets

Scans the codebase for accidentally committed secrets including API keys, tokens, passwords, private keys, and other sensitive credentials.

## Usage

```bash
/security:secrets [path]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `path` | No | Directory to scan (defaults to current project root) |

## Examples

```bash
/security:secrets
/security:secrets ./src
/security:secrets /path/to/project
```

## What It Does

1. Scans files for common secret patterns:
   - API keys (AWS, Stripe, GitHub, etc.)
   - Bearer tokens and JWTs
   - Database connection strings
   - Private keys (RSA, SSH, PEM)
   - Hardcoded passwords and credentials
2. Reports findings with file path, line number, and match type
3. Suggests remediation: rotate, move to env vars, add to `.gitignore`

## Connected Components

- **Skill:** None
- **Agent:** None
- **Pattern:** 1 (Direct execution)

## Notes

- Scans all text files; skips binary files and common non-code directories
- Respects `.gitignore` patterns by default
- Does NOT send any found secrets externally
- Always rotate compromised credentials immediately after detection
