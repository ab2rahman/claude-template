---
name: "Optimize Performance"
description: "Runs Lighthouse audits, identifies performance bottlenecks, implements fixes, and generates reports."
category: "seo"
---

# Optimize Performance

## Overview

Runs Lighthouse performance audits on a website, analyzes the scores and bottlenecks, implements performance fixes (image optimization, code splitting, caching, etc.), re-tests to measure improvement, and generates a before/after report.

## Trigger

This skill is triggered by:
- Command: `/seo:lighthouse`
- Direct request: "optimize site performance", "improve lighthouse score", "speed up my site"

## Prerequisites

- Target site URL provided and publicly accessible
- Lighthouse CLI or Chrome DevTools available
- Access to the site's source code for implementing fixes

## Agent

**Template:** `agents/seo-auditor-agent.md`

Spawns an seo-auditor agent to run audits and implement optimizations.

## Workflow

### Step 1: Analyze

- Run initial Lighthouse audit and capture baseline scores (Performance, A11y, Best Practices, SEO)
- Identify Core Web Vitals: LCP, FID/INP, CLS
- Analyze bottlenecks: render-blocking resources, large images, unminified code, unused JS/CSS
- Check server response times and caching headers

### Step 2: Plan

- Prioritize fixes by impact (largest contentful paint first, then layout shift, then input delay)
- Group fixes into quick wins and larger optimizations
- Estimate score improvement for each fix
- Create an implementation order that maximizes impact

### Step 3: Execute

- Optimize images: compress, convert to WebP/AVIF, add lazy loading, set dimensions
- Minify and bundle CSS/JS, remove unused code
- Implement code splitting for route-based lazy loading
- Add or fix caching headers (Cache-Control, ETag)
- Optimize fonts: preload, display:swap, subset
- Implement resource hints (preconnect, prefetch, preload)

### Step 4: Verify

- Re-run Lighthouse audit after all fixes are applied
- Compare before/after scores for each category
- Verify Core Web Vitals meet "good" thresholds
- Confirm no regressions in functionality

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  OPTIMIZE PERFORMANCE — COMPLETE  ║
╠════════════════════════════════════╣
║                                    ║
║  Lighthouse Scores (Before→After): ║
║  • Performance:  45 → 92          ║
║  • Accessibility: 88 → 95         ║
║  • Best Practices: 90 → 98        ║
║  • SEO: 82 → 100                  ║
║                                    ║
║  Core Web Vitals:                  ║
║  • LCP: 4.2s → 1.8s               ║
║  • CLS: 0.15 → 0.02               ║
║  • INP: 250ms → 80ms              ║
║                                    ║
║  Created:                          ║
║  • docs/performance-report.md      ║
║                                    ║
║  Next steps:                       ║
║  • Monitor in CrUX data            ║
║  • Set up performance budget       ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Full Optimization

```
/seo:lighthouse "https://example.com"
```

Expected result: Complete performance audit with fixes applied and before/after report.

### Example 2: Specific Fix

```
/seo:lighthouse "https://example.com" --fix=images
```

Expected result: Focused on image optimization only (compress, WebP, lazy load, dimensions).

## Error Handling

- **Lighthouse fails:** Check if site is accessible, try mobile vs desktop mode
- **Score regression:** Revert the last change and investigate the cause
- **Build tool mismatch:** Detect the bundler (Webpack, Vite, etc.) and use appropriate config
