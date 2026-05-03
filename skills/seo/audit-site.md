---
name: "Audit Site"
description: "Performs a comprehensive SEO audit covering meta tags, content, technical SEO, and performance."
category: "seo"
---

# Audit Site

## Overview

Performs a full SEO audit on a website by crawling pages, checking meta tags, analyzing content quality, verifying technical SEO best practices, measuring performance, and generating an actionable report with prioritized recommendations.

## Trigger

This skill is triggered by:
- Command: `/seo:audit`
- Direct request: "audit this site for SEO", "run SEO audit", "check my SEO"

## Prerequisites

- Target site URL provided
- Site is publicly accessible (or local server running)
- Lighthouse CLI available (for performance metrics)

## Agent

**Template:** `agents/seo-auditor-agent.md`

Spawns an seo-auditor agent to perform the comprehensive audit.

## Workflow

### Step 1: Analyze

- Crawl the target site and collect page URLs (up to configurable limit)
- Fetch HTML for each page and extract meta tags (title, description, canonical, og tags)
- Analyze heading structure (H1, H2, H3 hierarchy)
- Check for broken links, missing alt text, and duplicate content

### Step 2: Plan

- Categorize findings by severity (critical, warning, info)
- Group issues by type (meta tags, content, technical, performance)
- Prioritize fixes by estimated SEO impact
- Prepare comparison against top-ranking competitors if requested

### Step 3: Execute

- Run technical SEO checks: robots.txt, sitemap.xml, structured data, canonical tags
- Run content analysis: keyword density, readability score, content length
- Run performance checks via Lighthouse: Core Web Vitals, page speed
- Check mobile-friendliness and responsive design
- Generate the comprehensive audit report

### Step 4: Verify

- Cross-check critical issues by re-fetching affected pages
- Confirm all broken links are actually unreachable
- Validate structured data with Google's testing tool format
- Ensure recommendations are specific and actionable

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  SEO AUDIT — COMPLETE             ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • docs/seo-audit-report.md        ║
║                                    ║
║  Pages crawled: [count]            ║
║  Issues found:                     ║
║  • Critical: [count]               ║
║  • Warnings: [count]               ║
║  • Info: [count]                   ║
║                                    ║
║  Top priorities:                   ║
║  • [most impactful fix]            ║
║  • [second most impactful]         ║
║                                    ║
║  Next steps:                       ║
║  • Fix critical issues first       ║
║  • Run /seo:optimize-performance   ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Full Audit

```
/seo:audit "https://example.com"
```

Expected result: Complete audit report with all checks and prioritized recommendations.

### Example 2: Limited Scope

```
/seo:audit "https://example.com" --pages=10 --skip-performance
```

Expected result: Audit limited to 10 pages without Lighthouse performance checks.

## Error Handling

- **Site unreachable:** Verify URL and check if site is publicly accessible
- **Crawl blocked by robots.txt:** Respect robots.txt and audit only accessible pages
- **Lighthouse timeout:** Skip performance checks and note in report
