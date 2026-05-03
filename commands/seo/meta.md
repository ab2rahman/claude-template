---
name: "seo:meta"
description: "Generate meta tags, Open Graph tags, sitemap entries, and robots.txt rules"
category: "seo"
---

# /seo:meta

Generates SEO meta tags, Open Graph tags, sitemap XML entries, or robots.txt rules for a given page or site.

## Usage

```bash
/seo:meta [page-url] --type [type]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `page-url` | Yes | URL of the page or site |
| `--type` | No | Output type: `meta`, `sitemap`, `robots` (default: `meta`) |

## Examples

```bash
/seo:meta https://example.com/about --type meta
/seo:meta https://example.com --type sitemap
/seo:meta https://example.com --type robots
```

## What It Does

1. Fetches the target page content
2. Generates appropriate output based on `--type`:
   - **meta:** Title, description, OG tags, Twitter cards, canonical URL
   - **sitemap:** XML sitemap entry with priority and changefreq
   - **robots:** robots.txt rules with Allow/Disallow directives

## Connected Components

- **Agent:** `agent:seo-auditor-agent`
- **Pattern:** 2 (Command + Agent)

## Notes

- For `meta` type, outputs HTML ready to paste into `<head>`
- For `sitemap`, outputs XML snippet compatible with sitemap protocol
- For `robots`, follows standard robots.txt conventions
