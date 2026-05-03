---
name: "ios:api"
description: "Set up API networking layer with URLSession or Alamofire"
category: "ios"
---

# /ios:api

Scaffold a networking service layer for communicating with backend APIs.

## Usage

```
/ios:api [endpoint-name]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `[endpoint-name]` | Yes | Name of the API module (camelCase, e.g. `auth`, `users`) |

## Examples

```bash
/ios:api auth
/ios:api users
/ios:api products
```

## What It Does

1. Creates API service file at `Services/API/[EndpointName]Service.swift`
2. Defines Codable request and response models
3. Implements HTTP methods (GET, POST, PUT, DELETE) for the endpoint
4. Sets up error handling with custom APIError enum
5. Configures base URL and common headers

## Connected Components

- **Skill:** `skill:ios/setup-api`
- **Agent:** `agent:ios-dev-agent`

## Notes

- Uses URLSession by default; switches to Alamofire if detected in Podfile/SPM
- Supports async/await concurrency pattern
- Includes request logging for debug builds
