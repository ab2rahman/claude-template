---
name: "seo:content"
description: "Create SEO-optimized content with targeted keywords and proper structure"
category: "seo"
---

# /seo:content

Generates SEO-optimized content for a given topic, incorporating target keywords, proper heading hierarchy, meta descriptions, and structured recommendations.

## Usage

```bash
/seo:content [topic] --keywords [keywords]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `topic` | Yes | Topic or title for the content |
| `--keywords` | No | Comma-separated target keywords |

## Examples

```bash
/seo:content "Getting Started with Flutter" --keywords "flutter tutorial, flutter beginner, dart"
/seo:content "Best SEO Practices 2026" --keywords "seo tips, search optimization"
```

## What It Does

1. Researches the topic and target keywords
2. Structures content with proper H1-H6 hierarchy
3. Optimizes keyword density and placement
4. Generates meta title and description
5. Outputs ready-to-publish content with SEO metadata

## Connected Components

- **Skill:** `skill:seo/create-content`
- **Agent:** `agent:seo-auditor-agent`
- **Pattern:** 3 (Command → Skill → Agent)

## Notes

- Content length adapts to topic complexity
- Includes internal/external linking suggestions
- Outputs in Markdown format by default
