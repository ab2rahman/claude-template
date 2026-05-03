---
name: "python:lint"
description: "Run Python linters (ruff and mypy)"
category: "python"
---

# /python:lint

Run static analysis using ruff for linting and mypy for type checking.

## Usage

```bash
/python:lint
/python:lint --fix
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--fix` | No | Auto-fix linting issues where possible |

## Examples

### Check Only
```bash
/python:lint
```

### Auto-fix Issues
```bash
/python:lint --fix
```

## What It Does

1. Detects configuration (pyproject.toml, ruff.toml, mypy.ini)
2. Runs `ruff check .` for code style and quality issues
3. Runs `mypy .` for static type checking
4. With `--fix`: applies automatic fixes via `ruff check --fix .`
5. Reports all findings with file locations and descriptions

## Connected Components

*Simple command (Pattern 1). No skill or agent required.*

## Notes

- Requires ruff: `pip install ruff`
- Requires mypy: `pip install mypy`
- Uses project-level configuration if available
