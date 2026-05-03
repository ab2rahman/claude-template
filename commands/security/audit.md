---
name: "security:audit"
description: "Full security audit — server check, headers, SSL, open ports, and vulnerabilities"
category: "security"
---

# /security:audit

Performs a comprehensive security audit on a host, checking server configuration, security headers, SSL/TLS status, open ports, and common vulnerabilities.

## Usage

```bash
/security:audit [host-or-ip]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `host-or-ip` | Yes | Hostname, domain, or IP address to audit |

## Examples

```bash
/security:audit example.com
/security:audit 192.168.1.100
/security:audit myserver.example.com
```

## What It Does

1. Scans the target host for security posture
2. Checks SSL/TLS certificate validity and configuration
3. Analyzes HTTP security headers
4. Identifies open ports and running services
5. Tests for common vulnerabilities (misconfigurations, outdated software)
6. Generates a prioritized remediation report

## Connected Components

- **Skill:** `skill:security/audit-server`
- **Agent:** `agent:security-auditor-agent`
- **Pattern:** 3 (Command → Skill → Agent)

## Notes

- Only audit systems you own or have permission to test
- Does not perform destructive testing or exploitation
- Pair with `/security:headers` for detailed header analysis
