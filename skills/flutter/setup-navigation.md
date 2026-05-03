---
name: "Setup Flutter Navigation"
description: "Configures GoRouter or AutoRoute with routes, guards, and deep links"
category: "flutter"
---

# Setup Flutter Navigation

## Overview

Sets up or extends navigation in a Flutter project using GoRouter or AutoRoute. Handles route registration, route guards (authentication, authorization), deep link configuration, and nested navigation structures.

## Trigger

This skill is triggered by:
- Command: `/flutter:nav`
- Direct request: "setup navigation", "add routes", "configure deep links", "add route guard"

## Prerequisites

- Flutter project with `go_router` or `auto_route` dependency
- Existing screens to route to
- Understanding of auth state for guard setup

## Agent

**Template:** `agents/flutter-dev-agent.md`

## Workflow

### Step 1: Analyze

- Check if GoRouter or AutoRoute is already configured
- Read existing router file to understand current route structure
- Identify authentication provider for guard integration
- Check for existing shell/bottom-nav patterns (StatefulShellRoute)

### Step 2: Plan

- Map out route hierarchy (parent-child relationships)
- Identify routes needing authentication guards
- Plan deep link URL schemes if applicable
- Determine if nested navigation is needed

### Step 3: Execute

- Add new route definitions to router configuration
- Create redirect logic for authentication guards
- Configure deep link handling in route paths
- Set up ShellRoute or StatefulShellRoute for tab-based navigation if needed

### Step 4: Verify

- Run `flutter analyze` for compile errors
- Verify route transitions work as expected
- Test deep links with `flutter run` and URL scheme
- Confirm guards redirect unauthenticated users

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  SETUP NAVIGATION — COMPLETE      ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • lib/router/guards/[name]_guard.dart (if new guard)
║                                    ║
║  Modified:                         ║
║  • lib/router/app_router.dart      ║
║  • lib/main.dart (if new init)     ║
║                                    ║
║  Routes added:                     ║
║  • /home, /settings, /profile      ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Add Routes

```
/flutter:nav --add-routes "/orders,/orders/:id,/settings"
```

Adds three routes with the detail route accepting an ID parameter.

### Example 2: Auth Guard

```
/flutter:nav --add-guard auth
```

Adds authentication redirect guard protecting specified routes.

## Error Handling

- **No router found:** Create initial GoRouter setup from scratch
- **Duplicate route path:** Warn and suggest alternative paths
- **Missing auth provider:** Suggest running `setup-provider` skill first
