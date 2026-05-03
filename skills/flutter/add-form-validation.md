---
name: "Add Flutter Form Validation"
description: "Creates form widget with field validation, submit handler, and provider integration"
category: "flutter"
---

# Add Flutter Form Validation

## Overview

Creates a complete form with input validation, error display, and submission handling. Follows the project's existing form patterns and integrates with Riverpod for state management of form submission and API calls.

## Trigger

This skill is triggered by:
- Command: `/flutter:form`
- Direct request: "add a form", "create form with validation", "add input validation"

## Prerequisites

- Flutter project with Riverpod setup
- Target screen or widget where form will be placed
- Submission endpoint or callback defined

## Agent

**Template:** `agents/flutter-dev-agent.md`

## Workflow

### Step 1: Analyze

- Check existing forms in project for pattern (Form widget, TextFormField setup)
- Identify validation library used (built-in validators, formz, or custom)
- Read existing provider for submission state pattern (loading, success, error)
- Check for shared form field widgets or decoration styles

### Step 2: Plan

- List form fields with expected validation rules (required, email, min length, regex)
- Define form state class to hold field values and validation status
- Plan submission flow (validate → show loading → call API → handle result)
- Identify any dependent field validations (confirm password, etc.)

### Step 3: Execute

- Create form widget with GlobalKey<FormState>
- Add TextFormField widgets with appropriate validators
- Create form provider/notifier for submission state management
- Add submit handler with validation check and API call
- Add loading indicator and error/success feedback

### Step 4: Verify

- Run `flutter analyze` for compilation errors
- Test that empty form shows validation errors
- Test that invalid input is caught by validators
- Verify submission flow reaches provider correctly

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  ADD FORM VALIDATION — COMPLETE   ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • lib/features/[feature]/widgets/[name]_form.dart
║  • lib/features/[feature]/providers/[name]_form_provider.dart
║                                    ║
║  Modified:                         ║
║  • lib/features/[feature]/[name]_screen.dart
║                                    ║
║  Form fields:                      ║
║  • email (required, email format)  ║
║  • password (required, min 8 chars)║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Login Form

```
/flutter:form "login" --fields "email,password"
```

Creates login form with email and password validation, connects to auth provider.

### Example 2: Registration Form

```
/flutter:form "register" --fields "name,email,password,confirm"
```

Creates registration form with confirm password match validation.

## Error Handling

- **Missing field names:** Prompt user to specify required fields
- **No parent screen:** Suggest running `create-screen` skill first
- **Validation library mismatch:** Adapt to project's existing validator pattern
