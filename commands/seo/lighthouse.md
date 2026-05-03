---
name: "seo:lighthouse"
description: "Run Lighthouse performance audit — performance, accessibility, SEO, best practices"
category: "seo"
---

# /seo:lighthouse

Runs a Lighthouse performance audit on a URL, covering performance metrics, accessibility, SEO, and best practices with actionable optimization suggestions.

## Usage

```bash
/seo:lighthouse [url] --category [category]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `url` | Yes | Full URL to audit |
| `--category` | No | Audit category: `perf`, `accessibility`, `seo`, `all` (default: `all`) |

## Examples

```bash
/seo:lighthouse https://example.com --category all
/seo:lighthouse https://example.com --category perf
/seo:lighthouse https://example.com/shop --category accessibility
```

## What It Does

1. Runs Lighthouse audit on the target URL
2. Collects scores for selected categories (0-100)
3. Identifies specific issues with impact ratings
4. Provides prioritized optimization recommendations

## Connected Components

- **Skill:** `skill:seo/optimize-performance`
- **Agent:** `agent:seo-auditor-agent`
- **Pattern:** 3 (Command → Skill → Agent)

## Notes

- Requires Chrome/Chromium installed for Lighthouse CLI
- Scores may vary between runs; average multiple runs for accuracy
- Pair with `/seo:audit` for a complete SEO picture
