---
name: "Audit Server"
description: "Performs server security audit covering SSH, firewall, open ports, SSL, and user permissions."
category: "security"
---

# Audit Server

## Overview

Performs a comprehensive server security audit by checking SSH configuration, firewall rules, open ports, SSL/TLS certificates, user permissions, and system hardening. Generates a detailed report with severity-rated findings and remediation steps.

## Trigger

This skill is triggered by:
- Command: `/security:audit`
- Direct request: "audit server security", "check server hardening", "security audit my server"

## Prerequisites

- SSH access to the target server
- Sufficient privileges to read config files (sudo may be required)
- Server IP or hostname provided

## Agent

**Template:** `agents/security-auditor-agent.md`

Spawns a security-auditor agent to perform the server security assessment.

## Workflow

### Step 1: Analyze

- Connect to the server and gather system information (OS, kernel, uptime)
- Check SSH configuration: PermitRootLogin, PasswordAuthentication, Port, AllowUsers
- Enumerate open ports and running services with `ss` or `netstat`
- Review firewall rules (iptables, ufw, firewalld)

### Step 2: Plan

- Categorize checks: authentication, network, filesystem, SSL/TLS, services
- Determine severity for each finding (critical, high, medium, low, info)
- Prioritize checks that pose the highest risk
- Plan remediation steps for each category

### Step 3: Execute

- Audit SSH config against security best practices
- Check SSL/TLS certificates for expiry, weak ciphers, and protocol versions
- Review user accounts: weak passwords, sudo access, empty passwords
- Check file permissions on sensitive files (/etc/shadow, SSH keys, config files)
- Verify fail2ban or equivalent brute-force protection is active
- Check for unnecessary services and packages

### Step 4: Verify

- Confirm each finding with a secondary check
- Validate that recommended fixes are actionable and safe
- Ensure no false positives in the report
- Check that remediation steps won't break existing services

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  AUDIT SERVER — COMPLETE          ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • docs/security-audit-report.md   ║
║                                    ║
║  Findings:                         ║
║  • Critical: [count]               ║
║  • High: [count]                   ║
║  • Medium: [count]                 ║
║  • Low: [count]                    ║
║  • Info: [count]                   ║
║                                    ║
║  Top priorities:                   ║
║  • [most critical finding]         ║
║  • [second most critical]          ║
║                                    ║
║  Next steps:                       ║
║  • Fix critical findings ASAP      ║
║  • Schedule high findings          ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Full Audit

```
/security:audit "user@hostname"
```

Expected result: Complete security audit with all checks and prioritized remediation.

### Example 2: Quick Check

```
/security:audit "user@hostname" --quick --checks=ssh,firewall
```

Expected result: Focused audit on SSH and firewall configuration only.

## Error Handling

- **SSH connection failed:** Verify credentials and network connectivity
- **Insufficient privileges:** List checks that require sudo and suggest running with elevated access
- **Service disruption risk:** Flag dangerous remediation steps and require manual confirmation
