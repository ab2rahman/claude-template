---
name: "security:headers"
description: "Check security headers — CSP, HSTS, X-Frame-Options, and more"
category: "security"
---

# /security:headers

Analyzes HTTP security headers for a given URL, checking for presence and correct configuration of CSP, HSTS, X-Frame-Options, X-Content-Type-Options, and other security headers.

## Usage

```bash
/security:headers [url]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `url` | Yes | Full URL to check headers for |

## Examples

```bash
/security:headers https://example.com
/security:headers https://api.example.com/health
```

## What It Does

1. Fetches HTTP response headers from the target URL
2. Evaluates each security header for presence and correctness
3. Checks: Content-Security-Policy, Strict-Transport-Security, X-Frame-Options, X-Content-Type-Options, Referrer-Policy, Permissions-Policy
4. Provides recommendations for missing or misconfigured headers

## Connected Components

- **Skill:** `skill:security/check-headers`
- **Agent:** None (direct execution)
- **Pattern:** 2 (Command → Skill)

## Notes

- Uses standard HTTP requests — no special privileges required
- Compares against OWASP recommended header configurations
- Outputs ready-to-use header configuration snippets
