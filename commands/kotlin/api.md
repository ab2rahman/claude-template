---
name: "kotlin:api"
description: "Add Retrofit endpoint with API service interface"
category: "kotlin"
---

# /kotlin:api

Scaffold a Retrofit API service with endpoint definitions.

## Usage

```
/kotlin:api [endpoint-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `endpoint-name` | Yes | Endpoint group name in PascalCase (e.g., `UserApi`, `OrderApi`) |

## Examples

```
/kotlin:api UserApi
/kotlin:api ProductApi
```

## What It Does

1. Creates Retrofit API service interface
2. Defines endpoint methods with HTTP annotations
3. Creates request/response data classes
4. Adds Hilt module for DI provider

## Connected Components

- **Skill:** `skill:kotlin/setup-retrofit`
- **Agent:** `agent:kotlin-dev-agent`

## Notes

- Requires `retrofit` and `moshi`/`gson` converter dependencies
- Uses suspend functions for coroutine support
