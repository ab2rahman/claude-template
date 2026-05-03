---
name: "Setup iOS API Layer"
description: "Sets up a URLSession-based API layer with async/await, typed services, protocol-oriented design, and error handling for an iOS project."
category: "ios"
---

## Overview

Creates a modern Swift networking layer using URLSession with async/await, protocol-based API services, typed request/response models, and unified error handling following Swift concurrency best practices.

## Trigger

User requests API setup, networking layer, or backend integration in an iOS/SwiftUI project.

## Prerequisites

- Xcode project targeting iOS 15+ (for async/await) or iOS 13+ (with Combine)
- Backend API base URL known
- Authentication method identified (Bearer token, API key, etc.)

## Agent

**Agent Template:** `agents/ios-dev-agent.md`

Spawn instruction: Pass API base URL, auth method, and key API endpoints to scaffold.

## Workflow

### 1. Analyze
- Check for existing networking or API layer files
- Identify authentication mechanism and token storage
- Review existing model types that map to API responses
- Check for environment/configuration files for API URLs

### 2. Plan
- Define networking folder structure (Network/ or Services/)
- Design protocol-oriented API service pattern
- Plan error types and response wrapper
- Map out request builders per feature domain

### 3. Execute
- Create `NetworkError` enum conforming to `LocalizedError` for all error cases
- Create `NetworkManager` protocol and concrete implementation with URLSession
- Add async/await request methods (GET, POST, PUT, DELETE)
- Create `APIEndpoint` enum or struct for building requests with headers and query params
- Create typed API service protocols per feature domain
- Implement services with async/await and proper error propagation
- Add token injection via `URLRequest` headers
- Create `Codable` response wrapper if API uses envelope pattern

### 4. Verify
- Confirm all async methods handle cancellation with `Task` properly
- Verify error types cover network, decoding, and API-level errors
- Check token is injected securely (Keychain, not UserDefaults)
- Ensure `Codable` models match expected JSON structure

## Output

```
Created:
  - Network/NetworkError.swift         (error types)
  - Network/NetworkManager.swift        (URLSession wrapper)
  - Network/APIEndpoint.swift           (request builder)
  - Network/Services/{Feature}Service.swift  (typed API service)
  - Network/Protocols/{Feature}ServiceProtocol.swift  (service protocol)
```

## Examples

```
/ios:setup-api "base URL: https://api.example.com, auth: Bearer token"
/ios:setup-api "with auth service, products service, and keychain token storage"
```

## Error Handling

- **URLSession errors:** Catch `URLError` and map to custom `NetworkError` cases.
- **Decoding failures:** Log the raw response for debugging, return `.decodingFailed` with context.
- **Token expired (401):** Implement refresh token flow or surface error to ViewModel for re-auth.
- **No network:** Check `NWPathMonitor` or return `.noConnection` to show offline UI.
- **Timeout:** Configure `URLSessionConfiguration.timeoutIntervalForRequest` appropriately.
