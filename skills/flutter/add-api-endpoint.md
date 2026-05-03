---
name: "Add Flutter API Endpoint"
description: "Adds API endpoint with Dio client, model class, and repository pattern"
category: "flutter"
---

# Add Flutter API Endpoint

## Overview

Creates a complete API layer for a feature: Dio request setup, data model with serialization, repository class with error handling, and provider integration. Follows the project's existing API patterns.

## Trigger

This skill is triggered by:
- Command: `/flutter:api`
- Direct request: "add api endpoint", "create api service", "add network call"

## Prerequisites

- Flutter project with `dio` dependency
- Base URL and API configuration already set up
- Existing Dio client or interceptor pattern to follow

## Agent

**Template:** `agents/flutter-dev-agent.md`

## Workflow

### Step 1: Analyze

- Check existing API layer for patterns (Dio client setup, base repository)
- Identify model serialization approach (freezed + json_serializable, manual fromJson/toJson)
- Check for existing interceptors (auth token, logging, error handling)
- Read repository pattern used in the project

### Step 2: Plan

- Define model fields based on API response/request schema
- Determine endpoint URL, HTTP method, and parameters
- Plan error handling strategy (Either, Result type, try-catch)
- List Dio interceptor needs (auth header, refresh token)

### Step 3: Execute

- Create model class with `fromJson`/`toJson` (or freezed)
- Create repository class with Dio calls and error handling
- Create Dio interceptor if needed (auth, logging)
- Create provider that exposes repository to the widget tree
- Optionally add API response wrapper model

### Step 4: Verify

- Run `flutter analyze` for compilation errors
- Verify model serialization round-trips correctly
- Check interceptor chain is properly configured
- Confirm provider injects repository without errors

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  ADD API ENDPOINT — COMPLETE      ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • lib/features/[feature]/models/[name]_model.dart
║  • lib/features/[feature]/repositories/[name]_repository.dart
║  • lib/features/[feature]/providers/[name]_provider.dart
║                                    ║
║  Modified:                         ║
║  • lib/network/dio_client.dart (if interceptor added)
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Simple GET Endpoint

```
/flutter:api "products" --method GET --path /api/v1/products
```

Creates ProductModel, ProductRepository with list/get methods.

### Example 2: CRUD with Auth

```
/flutter:api "orders" --crud --auth
```

Creates full CRUD repository with auth interceptor.

## Error Handling

- **Dio not installed:** Prompt `flutter pub add dio`
- **Base URL missing:** Suggest adding to environment config
- **SSL/certificate issue:** Suggest certificate pinning setup
- **Serialization error:** Verify json_serializable or freezed setup
