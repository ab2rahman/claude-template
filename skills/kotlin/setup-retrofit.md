---
name: "Setup Retrofit API"
description: "Sets up Retrofit with API interface, DTO, Repository, interceptor, and Hilt module"
category: "kotlin"
---

# Setup Retrofit API

## Overview

Creates a complete Retrofit network layer for a feature: API interface with endpoint definitions, DTO data classes, Repository with error handling, OkHttp interceptor configuration, and Hilt module for dependency injection.

## Trigger

This skill is triggered by:
- Command: `/kotlin:api`
- Direct request: "setup retrofit", "add api service", "create network layer", "add retrofit endpoint"

## Prerequisites

- Android project with Retrofit, OkHttp, and Moshi/Gson converter dependencies
- Hilt dependency injection configured
- Base URL configured in build config or BuildConfig

## Agent

**Template:** `agents/kotlin-dev-agent.md`

## Workflow

### Step 1: Analyze

- Check existing Retrofit setup for base URL, converter, and client configuration
- Read existing API interfaces for endpoint definition patterns
- Identify DTO serialization approach (Moshi, Gson, Kotlin Serialization)
- Check for existing interceptors (auth, logging, error handling)

### Step 2: Plan

- Define API endpoints with HTTP methods, paths, and parameters
- Create DTO classes matching API request/response schemas
- Plan interceptor needs (auth token header, request logging)
- Determine error handling strategy (NetworkResult sealed class, try-catch)

### Step 3: Execute

- Create DTO data classes with serialization annotations
- Create Retrofit API interface with endpoint methods
- Create Repository class with error handling and Response wrapper
- Configure OkHttp interceptor (auth header, logging, error interceptor)
- Create Hilt module providing API service and repository

### Step 4: Verify

- Build project with `./gradlew assembleDebug` to confirm compilation
- Verify Retrofit interface methods match endpoint specifications
- Check Hilt module provides all dependencies correctly
- Confirm interceptor chain is properly ordered

## Output

After execution, report:

```
╔════════════════════════════════════╗
║  SETUP RETROFIT API — COMPLETE    ║
╠════════════════════════════════════╣
║                                    ║
║  Created:                          ║
║  • data/remote/dto/[Name]Dto.kt    ║
║  • data/remote/api/[Name]Api.kt    ║
║  • data/repository/[Name]RepositoryImpl.kt
║  • di/NetworkModule.kt (updated)   ║
║                                    ║
║  Endpoints:                        ║
║  • GET /api/v1/[resource]          ║
║  • POST /api/v1/[resource]         ║
║                                    ║
╚════════════════════════════════════╝
```

## Examples

### Example 1: Simple GET API

```
/kotlin:api "products" --endpoints "GET /api/v1/products,GET /api/v1/products/{id}"
```

Creates ProductDto, ProductApi with list and detail endpoints.

### Example 2: Full CRUD with Auth

```
/kotlin:api "orders" --crud --auth-interceptor
```

Creates full CRUD API with auth token interceptor and Hilt module.

## Error Handling

- **Retrofit not in dependencies:** Add Retrofit + converter to build.gradle
- **Base URL missing:** Add to BuildConfig or local.properties
- **SSL pinning needed:** Add certificate pinner to OkHttp client
- **Hilt not set up:** Guide Hilt application class and plugin configuration
