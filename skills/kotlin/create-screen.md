---
name: "Create Kotlin Screen"
description: "Creates Jetpack Compose screen with ViewModel, sealed state class, and navigation registration"
category: "kotlin"
---

# Create Kotlin Screen

## Overview

Generates a complete Compose screen with its ViewModel, sealed state/interface class for UI state management, and registers the destination in the Navigation Compose graph. Follows unidirectional data flow pattern (ViewModel + StateFlow).

## Trigger

This skill is triggered by:
- Command: `/kotlin:screen`
- Direct request: "create compose screen", "add new screen", "create viewmodel screen"

## Prerequisites

- Android project with Jetpack Compose and Navigation Compose dependencies
- Hilt or Koin for dependency injection configured
- Existing screen files to reference for project patterns

## Agent

**Template:** `agents/kotlin-dev-agent.md`

## Workflow

### Step 1: Analyze

- Read 2-3 existing screen files to identify Compose patterns (function signatures, previews)
- Check ViewModel patterns (HiltViewModel, state management approach)
- Examine navigation graph for destination registration pattern
- Identify sealed class/interface pattern for UI state

### Step 2: Plan

- Define sealed state class with Loading, Success, Error subtypes
- Determine ViewModel dependencies (use cases, repositories)
- Plan Composable function parameters and preview setup
- Identify shared UI components to reuse

### Step 3: Execute

- Create sealed state/interface class with all necessary subtypes
- Create ViewModel with `StateFlow<UiState>` and intent/action methods
- Create Composable screen function with state handling
- Register destination in NavHost with route and arguments
- Add `@Preview` annotation for design preview

### Step 4: Verify

- Build project with `./gradlew assembleDebug` to confirm compilation
- Verify ViewModel injects dependencies correctly
- Check navigation destination is reachable
- Confirm Compose preview renders without errors

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  CREATE KOTLIN SCREEN — COMPLETE  ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • ui/screens/[Name]Screen.kt      ║
║  • ui/screens/[Name]ViewModel.kt   ║
║  • ui/screens/[Name]UiState.kt     ║
║                                    ║
║  Modified:                         ║
║  • navigation/NavGraph.kt          ║
║                                    ║
║  Next steps:                       ║
║  • Implement screen UI layout      ║
║  • Add unit tests for ViewModel    ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Basic Screen

```
/kotlin:screen "profile"
```

Creates `ProfileScreen`, `ProfileViewModel`, `ProfileUiState`, registers `profile` route.

### Example 2: Screen with Arguments

```
/kotlin:screen "order-detail" --args "orderId:String"
```

Creates screen accepting `orderId` argument via navigation.

## Error Handling

- **Compose not set up:** Guide user to add Compose dependencies
- **Hilt not configured:** Suggest adding Hilt plugin and setup
- **Duplicate route:** Warn and suggest alternative route names
