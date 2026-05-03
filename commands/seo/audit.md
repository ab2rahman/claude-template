---
name: "seo:audit"
description: "Full SEO audit of a website — technical, content, and on-page analysis"
category: "seo"
---

# /seo:audit

Performs a comprehensive SEO audit of a website, covering technical SEO, on-page factors, content quality, and actionable recommendations.

## Usage

```bash
/seo:audit [url]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `url` | Yes | Full URL of the website or page to audit |

## Examples

```bash
/seo:audit https://example.com
/seo:audit https://example.com/blog/my-article
```

## What It Does

1. Fetches and analyzes the target page
2. Checks technical SEO: meta tags, headings, structured data, canonical URLs
3. Evaluates content quality: keyword usage, readability, length
4. Reviews on-page factors: images, internal links, URL structure
5. Generates a prioritized list of recommendations

## Connected Components

- **Skill:** `skill:seo/audit-site`
- **Agent:** `agent:seo-auditor-agent`
- **Pattern:** 3 (Command → Skill → Agent)

## Notes

- Audits a single page by default; for site-wide audits, run on key pages
- Pair with `/seo:lighthouse` for performance-specific metrics
- Output includes severity ratings: critical, warning, info
