---
name: "Check Security Headers"
description: "Audits HTTP security headers on a web server and provides recommendations."
category: "security"
---

# Check Security Headers

## Overview

Audits the HTTP security headers returned by a web server or application. Checks for presence and correctness of headers like Content-Security-Policy, X-Frame-Options, Strict-Transport-Security, and more. Generates a report with compliance status and remediation steps.

## Trigger

This skill is triggered by:
- Command: `/security:headers`
- Direct request: "check security headers", "audit HTTP headers", "security header scan"

## Prerequisites

- Target URL accessible over HTTP/HTTPS
- curl or equivalent HTTP client available

## Agent

**Template:** `agents/security-auditor-agent.md`

Spawns a security-auditor agent to perform the HTTP header analysis.

## Workflow

### Step 1: Analyze

- Send HTTP request to the target URL and capture response headers
- Identify which security headers are present and which are missing
- Check values of present headers against recommended configurations

### Step 2: Plan

- Map each header to its security purpose
- Determine severity of missing or misconfigured headers
- Prepare specific recommendations with Nginx/Apache/Express config snippets

### Step 3: Execute

- Check for: X-Frame-Options, X-Content-Type-Options, Strict-Transport-Security, Content-Security-Policy, Referrer-Policy, Permissions-Policy, X-XSS-Protection
- Validate HSTS max-age, includeSubDomains, preload directives
- Review CSP for overly permissive directives (unsafe-inline, unsafe-eval, wildcard sources)
- Check for information-leaking headers (X-Powered-By, Server)

### Step 4: Verify

- Confirm each finding with a secondary request
- Ensure recommendations don't break existing functionality
- Validate configuration snippets for syntax correctness

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  SECURITY HEADERS — REPORT        ║
╠════════════════════════════════════╣
║                                    ║
║  Score: [X]/10 headers present     ║
║                                    ║
║  Present:                          ║
║  • Header: Value                   ║
║                                    ║
║  Missing:                          ║
║  • Header (severity)               ║
║                                    ║
║  Misconfigured:                    ║
║  • Header: issue description       ║
║                                    ║
║  Recommendations:                  ║
║  • [config snippet to add]         ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Basic Header Check

```
/security:headers https://example.com
```

Expected result: Full security header audit with compliance score and fixes.

### Example 2: With Config Output

```
/security:headers https://example.com --config nginx
```

Expected result: Header audit plus ready-to-use Nginx configuration snippet.

## Error Handling

- **Connection refused:** Verify the URL is correct and the server is running
- **SSL certificate error:** Flag as critical finding and suggest certificate fix
- **Redirect loop:** Report the issue and suggest checking redirect configuration
