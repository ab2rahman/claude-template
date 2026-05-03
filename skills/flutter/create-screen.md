---
name: "Create Flutter Screen"
description: "Creates a full Flutter screen with widget, provider/notifier, and route registration"
category: "flutter"
---

# Create Flutter Screen

## Overview

Generates a complete Flutter screen following the project's established patterns. Creates the widget file as a Riverpod ConsumerWidget or ConsumerStatefulWidget, a corresponding provider/notifier for state management, and registers the route in GoRouter.

## Trigger

This skill is triggered by:
- Command: `/flutter:screen`
- Direct request: "create a new screen", "add a new page", "new flutter screen"

## Prerequisites

- Flutter project with Riverpod (`flutter_riverpod`) dependency
- GoRouter (`go_router`) configured in the project
- Existing `lib/` directory structure with screens and providers folders

## Agent

**Template:** `agents/flutter-dev-agent.md`

## Workflow

### Step 1: Analyze

- Read 2-3 existing screen files to identify naming conventions, folder structure, and widget patterns
- Check existing provider files for notifier patterns (AsyncNotifier vs Notifier)
- Examine router configuration file for route registration pattern
- Identify if project uses `ConsumerWidget` or `ConsumerStatefulWidget`

### Step 2: Plan

- Determine file paths for widget, provider, and optional test
- List required imports based on existing patterns
- Note any shared widgets or utilities to reuse

### Step 3: Execute

- Create widget file as Riverpod consumer with proper state handling
- Create provider/notifier class with initial state and necessary methods
- Register route in GoRouter with correct path and optional parameters
- Optionally create a basic widget test file

### Step 4: Verify

- Run `flutter analyze` to check for lint issues
- Verify route is properly registered and accessible
- Confirm provider initializes without errors

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  CREATE FLUTTER SCREEN — COMPLETE ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • lib/features/[feature]/[name]_screen.dart
║  • lib/features/[feature]/[name]_provider.dart
║                                    ║
║  Modified:                         ║
║  • lib/router/app_router.dart      ║
║                                    ║
║  Next steps:                       ║
║  • Implement screen UI details     ║
║  • Add unit tests for notifier     ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Basic Screen

```
/flutter:create-screen "profile"
```

Creates `ProfileScreen`, `profileProvider`, registers `/profile` route.

### Example 2: Feature Screen

```
/flutter:create-screen "order-detail" --feature orders
```

Creates screen inside `lib/features/orders/` with feature-scoped provider.

## Error Handling

- **Missing GoRouter config:** Prompt user to set up routing first via `setup-navigation` skill
- **Riverpod not found:** Suggest running `flutter pub add flutter_riverpod`
- **Duplicate route:** Warn user and suggest alternative path names
