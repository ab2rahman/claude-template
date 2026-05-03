---
name: "flutter:api"
description: "Add API endpoint with Dio client integration"
category: "flutter"
---

# /flutter:api

Scaffold a new API endpoint with Dio HTTP client.

## Usage

```
/flutter:api [endpoint-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `endpoint-name` | Yes | Endpoint name in camelCase (e.g., `getUsers`, `postOrder`) |

## Examples

```
/flutter:api getUsers
/flutter:api postOrder
/flutter:api deleteCartItem
```

## What It Does

1. Creates API service method with Dio
2. Adds request/response model classes
3. Integrates with existing Dio client configuration
4. Includes error handling and response parsing

## Connected Components

- **Skill:** `skill:flutter/add-api-endpoint`
- **Agent:** `agent:flutter-dev-agent`

## Notes

- Requires `dio` package in `pubspec.yaml`
- Endpoint name determines HTTP method prefix convention
