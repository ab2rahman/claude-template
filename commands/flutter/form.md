---
name: "flutter:form"
description: "Create a form widget with validation logic"
category: "flutter"
---

# /flutter:form

Scaffold a Flutter form with field validation and submission handling.

## Usage

```
/flutter:form [form-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `form-name` | Yes | Form name in PascalCase (e.g., `LoginForm`, `RegisterForm`) |

## Examples

```
/flutter:form LoginForm
/flutter:form CheckoutForm
/flutter:form ProfileEditForm
```

## What It Does

1. Creates form widget with GlobalKey<FormState>
2. Adds TextFormField widgets with validators
3. Implements submit logic with loading state
4. Includes error display and success callbacks

## Connected Components

- **Skill:** `skill:flutter/add-form-validation`
- **Agent:** `agent:flutter-dev-agent`

## Notes

- Generates standard Flutter form patterns
- Validators use `FormFieldValidator` convention
