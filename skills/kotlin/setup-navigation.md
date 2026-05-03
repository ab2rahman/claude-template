---
name: "Setup Kotlin Navigation"
description: "Configures Navigation Compose with destinations, arguments, deep links, and transitions"
category: "kotlin"
---

# Setup Kotlin Navigation

## Overview

Sets up or extends Jetpack Navigation Compose in an Android project. Handles destination registration, type-safe arguments, deep link configuration, and custom transition animations between screens.

## Trigger

This skill is triggered by:
- Command: `/kotlin:nav`
- Direct request: "setup navigation compose", "add nav destination", "configure deep links"

## Prerequisites

- Android project with `navigation-compose` dependency
- Existing Composable screens to navigate between
- NavHost already set up or needs initial creation

## Agent

**Template:** `agents/kotlin-dev-agent.md`

## Workflow

### Step 1: Analyze

- Check existing NavHost and NavController setup
- Read current navigation graph for destination patterns
- Identify if type-safe navigation (Navigation 2.8+) or route strings are used
- Check for existing bottom navigation or nested graph patterns

### Step 2: Plan

- Map destination routes and their arguments
- Identify screens needing deep link support
- Plan transition animations (fade, slide, shared element)
- Determine navigation graph structure (flat vs nested)

### Step 3: Execute

- Add composable destinations to NavHost with routes
- Define navigation arguments with type safety (if supported)
- Add deep link intent filters and nav deep links
- Configure enter/exit transitions for destinations
- Set up bottom navigation bar integration if needed

### Step 4: Verify

- Build project to confirm no compilation errors
- Verify navigation actions work between all destinations
- Test deep links with `adb shell am start -a VIEW -d`
- Confirm back stack behavior is correct

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  SETUP NAVIGATION — COMPLETE      ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • navigation/[Feature]Navigation.kt (if new graph)
║                                    ║
║  Modified:                         ║
║  • navigation/NavGraph.kt          ║
║  • AndroidManifest.xml (deep links)║
║                                    ║
║  Destinations added:               ║
║  • home, orders/{id}, settings     ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Add Destinations

```
/kotlin:nav --add "orders,orders/{orderId},order-history"
```

Adds three destinations with parameterized order detail route.

### Example 2: Deep Links

```
/kotlin:nav --deep-links "myapp://orders/{orderId}"
```

Configures deep link with URI scheme and host.

## Error Handling

- **No NavHost found:** Create initial NavHost setup in main activity
- **Route conflict:** Warn about duplicate routes and suggest alternatives
- **Type mismatch:** Verify argument types match Compose navigation types
