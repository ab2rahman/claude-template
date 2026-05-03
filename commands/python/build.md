---
name: "python:build"
description: "Build and install Python package"
category: "python"
---

# /python:build

Build and install the Python package using pip or build tools.

## Usage

```bash
/python:build
/python:build --prod
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--prod` | No | Build production distribution (wheel/sdist) |

## Examples

### Basic Usage
```bash
/python:build
```

### Production Build
```bash
/python:build --prod
```

## What It Does

1. Detects build system (setup.py, pyproject.toml, or setup.cfg)
2. Runs `pip install -e .` for editable install (default)
3. With `--prod`: runs `python -m build` to generate dist artifacts
4. Validates installation by importing the package

## Connected Components

*Simple command (Pattern 1). No skill or agent required.*

## Notes

- Requires an active virtual environment
- For `--prod`, install `build` package first: `pip install build`
- Cleans previous build artifacts before building
