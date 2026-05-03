---
name: "security:deps"
description: "Scan dependencies for known vulnerabilities using audit tools"
category: "security"
---

# /security:deps

Scans project dependencies for known vulnerabilities using the appropriate package audit tool (`npm audit`, `pip audit`, or `cargo audit`).

## Usage

```bash
/security:deps [--fix]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--fix` | No | Automatically apply safe fixes where available |

## Examples

```bash
/security:deps
/security:deps --fix
```

## What It Does

1. Detects the project's package manager (npm/yarn/pip/cargo)
2. Runs the appropriate audit command
3. Parses vulnerability results by severity (critical/high/moderate/low)
4. Lists affected packages with CVE references
5. With `--fix`, applies non-breaking patches automatically

## Connected Components

- **Skill:** None
- **Agent:** None
- **Pattern:** 1 (Direct execution)

## Notes

- Auto-detects project type from lockfiles (`package.json`, `requirements.txt`, `Cargo.toml`)
- For npm: runs `npm audit` (or `npm audit fix` with `--fix`)
- For Python: runs `pip audit` (requires `pip-audit` installed)
- For Rust: runs `cargo audit` (requires `cargo-audit` installed)
