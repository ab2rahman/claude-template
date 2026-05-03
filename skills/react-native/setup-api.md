---
name: "Setup React Native API Layer"
description: "Sets up Axios or fetch-based API layer with interceptors, typed services, and error handling for a React Native project."
category: "react-native"
---

## Overview

Creates a robust API communication layer using Axios (preferred) or fetch, with request/response interceptors, typed API services, and unified error handling.

## Trigger

User requests API setup, HTTP client configuration, or backend integration in a React Native project.

## Prerequisites

- React Native project with TypeScript
- `axios` installed (if using Axios)
- Backend API base URL known
- API authentication method identified (token, API key, etc.)

## Agent

**Agent Template:** `agents/react-native-dev-agent.md`

Spawn instruction: Pass API base URL, auth method, and key API endpoints to scaffold.

## Workflow

### 1. Analyze
- Check for existing API or network layer files
- Identify authentication mechanism (Bearer token, refresh tokens)
- Review existing type definitions for API responses
- Check environment variable setup for API URLs

### 2. Plan
- Define API folder structure (api/ or services/)
- Map out interceptors needed (auth injection, token refresh, logging)
- Plan service files per feature domain
- Define error handling strategy

### 3. Execute
- Create Axios instance with base URL and default headers
- Add request interceptor for auth token injection
- Add response interceptor for error normalization and token refresh
- Create typed API service files per feature domain
- Define TypeScript interfaces for request/response payloads
- Create custom error class for API errors
- Export a React Query / SWR hook pattern if applicable

### 4. Verify
- Confirm interceptors attach and detach correctly
- Verify TypeScript types cover all request/response shapes
- Check error handling catches network and API-level errors
- Ensure tokens are securely read from storage (not hardcoded)

## Output

```
Created:
  - api/client.ts              (Axios instance + interceptors)
  - api/types.ts               (shared API types)
  - api/errors.ts              (custom error classes)
  - api/services/{feature}.ts  (feature API service)
  - api/index.ts               (barrel exports)
```

## Examples

```
/react-native:setup-api "base URL: https://api.example.com, auth: Bearer token"
/react-native:setup-api "with refresh token flow and user + products services"
```

## Error Handling

- **Missing axios:** Provide install command (`npm install axios`).
- **Token storage not found:** Recommend using `react-native-keychain` or `@react-native-async-storage/async-storage`.
- **Network errors:** Ensure interceptors handle `AxiosError` and provide user-friendly messages.
- **Refresh token loop:** Implement max retry count to prevent infinite refresh loops.
