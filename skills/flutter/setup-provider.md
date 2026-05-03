---
name: "Setup Flutter Provider"
description: "Sets up Riverpod state management for a feature with notifier and provider"
category: "flutter"
---

# Setup Flutter Provider

## Overview

Creates Riverpod state management scaffolding for a feature. Generates a notifier class, provider definition, and state class following the project's established patterns. Integrates the provider with the target screen.

## Trigger

This skill is triggered by:
- Command: `/flutter:provider`
- Direct request: "add a provider", "setup riverpod", "create state management"

## Prerequisites

- Flutter project with `flutter_riverpod` dependency
- Existing feature directory or screen file to integrate with
- State class pattern identified (freezed, equatable, or plain class)

## Agent

**Template:** `agents/flutter-dev-agent.md`

## Workflow

### Step 1: Analyze

- Check existing providers in the project for pattern (AsyncNotifier, Notifier, StateNotifier)
- Identify state modeling approach (freezed, equatable, plain Dart class)
- Check if `riverpod_generator` (code generation) or hand-written providers are used
- Read the target screen to understand integration points

### Step 2: Plan

- Define state class shape based on feature requirements
- Determine notifier type (async vs sync, family vs regular)
- List repository or service dependencies the provider needs

### Step 3: Execute

- Create state class with all required fields
- Create notifier class with build method and action methods
- Create provider definition with proper dependencies
- Integrate provider into target screen via `ref.watch` / `ref.read`

### Step 4: Verify

- Run `flutter analyze` to confirm no lint errors
- Verify provider compiles and state class is immutable
- Check screen correctly reacts to state changes

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  SETUP PROVIDER — COMPLETE        ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • lib/features/[feature]/[name]_state.dart
║  • lib/features/[feature]/[name]_notifier.dart
║  • lib/features/[feature]/[name]_provider.dart
║                                    ║
║  Modified:                         ║
║  • lib/features/[feature]/[name]_screen.dart
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Basic Provider

```
/flutter:provider "cart"
```

Creates `CartState`, `CartNotifier`, `cartProvider` with add/remove/clear methods.

### Example 2: Async Provider with Family

```
/flutter:provider "user-profile" --async --family
```

Creates async notifier that fetches user by ID parameter.

## Error Handling

- **Riverpod not installed:** Prompt `flutter pub add flutter_riverpod`
- **Pattern mismatch:** If code-gen pattern detected, use `@riverpod` annotations
- **Circular dependency:** Warn if provider depends on itself
