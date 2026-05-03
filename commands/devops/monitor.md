---
name: "devops:monitor"
description: "Health check and log monitoring"
category: "devops"
---

# /devops:monitor

Check application health, view logs, and monitor running services.

## Usage

```bash
/devops:monitor
/devops:monitor --logs
/devops:monitor --service [name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--logs` | No | Show recent application logs |
| `--service` | No | Monitor specific service by name |

## Examples

### Health Check
```bash
/devops:monitor
```

### View Logs
```bash
/devops:monitor --logs
```

### Specific Service
```bash
/devops:monitor --service "api"
```

## What It Does

1. Detects running services (Docker, PM2, systemd, or raw processes)
2. Runs health checks on configured endpoints
3. Shows container/process status and resource usage
4. With `--logs`: tails recent log output
5. Reports any issues or warnings found

## Connected Components

*Simple command (Pattern 1). No skill or agent required.*

## Notes

- Auto-detects monitoring method based on project setup
- Supports Docker, PM2, and direct health endpoints
- Requires services to be running for meaningful output
