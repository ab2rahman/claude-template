---
name: "react-native:api"
description: "Set up API layer with fetch or axios for a specific endpoint"
category: "react-native"
---

# /react-native:api

Scaffold an API service layer for communicating with backend endpoints.

## Usage

```
/react-native:api [endpoint-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[endpoint-name]` | Yes | Name of the API endpoint/module (e.g. `auth`, `users`) |

## Examples

```bash
/react-native:api auth
/react-native:api users
/react-native:api products
```

## What It Does

1. Creates API service file at `src/services/api/[endpointName].ts`
2. Sets up base HTTP client configuration (fetch or axios)
3. Generates typed request/response interfaces
4. Implements CRUD operations for the endpoint
5. Configures interceptors for auth tokens and error handling

## Connected Components

- **Skill:** `skill:react-native/setup-api`
- **Agent:** `agent:react-native-dev-agent`

## Notes

- Requires base API configuration (base URL, headers) in environment
- Supports both fetch API and axios — checks project dependencies
- Includes request/response type safety out of the box
