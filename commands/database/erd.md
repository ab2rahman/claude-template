---
name: "database:erd"
description: "Generate Entity-Relationship Diagram"
category: "database"
---

# /database:erd

Generate an Entity-Relationship Diagram from the current database schema or models.

## Usage

```bash
/database:erd
/database:erd --format mermaid
/database:erd --format svg
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--format` | No | Output format: mermaid, svg, or png (default: mermaid) |

## Examples

### Mermaid Output
```bash
/database:erd
```

### SVG Diagram
```bash
/database:erd --format svg
```

## What It Does

1. Introspects database schema or ORM models
2. Identifies all tables, columns, and relationships
3. Generates ERD in the specified format
4. Includes cardinality labels and key indicators
5. Outputs to console or file depending on format

## Connected Components


- **Skill:** `skill:database/design-schema`
- **Agent:** `agent:database-architect-agent`

## Notes

- Works with existing database or ORM model files
- Mermaid output can be rendered in Markdown or Figma
- SVG/PNG output requires graphviz or mermaid-cli installed
