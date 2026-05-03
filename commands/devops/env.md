---
name: "devops:env"
description: "Set up environment from template and validate"
category: "devops"
---

# /devops:env

Initialize environment configuration from template and validate required variables.

## Usage

```bash
/devops:env
/devops:env --validate
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--validate` | No | Validate existing .env without creating new one |

## Examples

### Setup Environment
```bash
/devops:env
```

### Validate Only
```bash
/devops:env --validate
```

## What It Does

1. Checks for `.env.template` in project root
2. Copies template to `.env` if it does not exist
3. Lists all required variables that need values
4. Validates that all required variables are filled
5. Reports missing or empty variables with descriptions

## Connected Components

*Simple command (Pattern 1). No skill or agent required.*

## Notes

- Never overwrites existing `.env` files
- Requires `.env.template` to exist in the project
- Check `.gitignore` ensures `.env` is not tracked
