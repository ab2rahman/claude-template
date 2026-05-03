---
name: "node:api-docs"
description: "Generate Swagger/OpenAPI documentation from route definitions"
category: "node"
---

# /node:api-docs

Generates API documentation in Swagger/OpenAPI format from existing Express routes.

## Usage

```
/node:api-docs [--format json|yaml]
```

## Arguments

| Argument  | Required | Description                              |
|-----------|----------|------------------------------------------|
| `--format`| No       | Output format: json or yaml (default: yaml)|

## Examples

```
/node:api-docs
/node:api-docs --format json
/node:api-docs --format yaml
```

## What It Does

1. Scans all route and controller files
2. Extracts endpoints, parameters, and response types
3. Generates OpenAPI 3.0 specification
4. Outputs to docs/ directory

## Connected Components

**Pattern 2 — Skill Only**
- **Skill:** `skill:node/create-route`
- **Agent:** None (skill handles generation)

## Notes

- Requires JSDoc or decorator annotations for best results
- Output can be served via swagger-ui-express
