---
name: "Create Content"
description: "Generates SEO-optimized content with keyword research, competitor analysis, and proper meta tags."
category: "seo"
---

# Create Content

## Overview

Generates SEO-optimized content by researching target keywords, analyzing competitor content, creating a structured outline, writing the full article, and adding appropriate meta tags. Ensures readability and keyword optimization throughout.

## Trigger

This skill is triggered by:
- Command: `/seo:content`
- Direct request: "write SEO content", "create SEO article", "optimize this content"

## Prerequisites

- Target topic or keyword provided
- Target audience and tone defined
- Content format specified (blog post, landing page, product description)

## Agent

**Template:** `agents/seo-auditor-agent.md`

Spawns an seo-auditor agent to handle research, writing, and optimization.

## Workflow

### Step 1: Analyze

- Research the target keyword: search volume, difficulty, related terms
- Analyze top-ranking competitor content for the keyword
- Identify content gaps and opportunities in existing results
- Determine optimal word count based on competitor analysis

### Step 2: Plan

- Create a content outline with H2/H3 heading structure
- Map primary and secondary keywords to sections
- Plan internal linking opportunities
- Define the meta title and meta description targets

### Step 3: Execute

- Write the content following the approved outline
- Optimize keyword placement (title, headings, first paragraph, naturally throughout)
- Add internal links to relevant existing content
- Create meta title (under 60 chars) and meta description (under 160 chars)
- Add Open Graph and Twitter Card meta tags
- Generate structured data (Article schema) if applicable

### Step 4: Verify

- Check keyword density is within healthy range (1-2%)
- Verify readability score (Flesch-Kincaid appropriate for target audience)
- Confirm meta title and description lengths are within limits
- Ensure all headings follow proper hierarchy (H1 > H2 > H3)

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  CREATE CONTENT — COMPLETE        ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • content/[slug].md               ║
║                                    ║
║  Word count: [count]               ║
║  Primary keyword: [keyword]        ║
║  Keyword density: [%]              ║
║  Readability: [score]              ║
║                                    ║
║  Meta title: [title]               ║
║  Meta description: [desc]          ║
║                                    ║
║  Next steps:                       ║
║  • Review content for brand voice  ║
║  • Add images with alt text        ║
║  • Publish and submit to Search    ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Blog Post

```
/seo:content "best project management tools for startups"
```

Expected result: Full SEO-optimized blog post with meta tags targeting the given keyword.

### Example 2: With Keywords

```
/seo:content "cloud migration guide" --keywords="cloud migration, AWS migration, Azure" --format=guide
```

Expected result: Long-form guide targeting multiple related keywords with proper structure.

## Error Handling

- **No keyword data:** Proceed with topic analysis and suggest alternative keywords
- **Low search volume:** Inform user and suggest higher-volume alternatives
- **Readability too low:** Simplify language and shorten sentences
