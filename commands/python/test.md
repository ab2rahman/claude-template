---
name: "python:test"
description: "Run Python tests with pytest"
category: "python"
---

# /python:test

Run the test suite using pytest with optional coverage reporting.

## Usage

```bash
/python:test
/python:test [test-path]
/python:test [test-path] --coverage
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[test-path]` | No | Specific test file or directory to run |
| `--coverage` | No | Generate coverage report |

## Examples

### Run All Tests
```bash
/python:test
```

### Run Specific Test File
```bash
/python:test "tests/test_auth.py"
```

### Run with Coverage
```bash
/python:test --coverage
```

## What It Does

1. Detects pytest configuration (pyproject.toml or pytest.ini)
2. Runs `pytest` on the specified path or entire test suite
3. With `--coverage`: runs `pytest --cov --cov-report=term-missing`
4. Reports results and any failures

## Connected Components

*Simple command (Pattern 1). No skill or agent required.*

## Notes

- Requires pytest installed: `pip install pytest`
- For coverage: `pip install pytest-cov`
- Uses project's pytest configuration if available
