---
name: "Setup Authentication"
description: "Integrates NextAuth.js or custom authentication into a Next.js App Router project."
category: "nextjs"
---

# Setup Authentication

## Overview

Sets up authentication in a Next.js App Router project using NextAuth.js v5 (Auth.js) or a custom JWT-based approach. Configures providers, session management, protected routes via middleware, and auth-aware UI components.

## Trigger

- Direct request: "setup authentication", "add login system", "setup nextauth"
- When building features that require user authentication

## Prerequisites

- Existing Next.js project with App Router
- `next-auth` package available or ready to install
- Database configured (for user storage) or external auth provider credentials

## Agent

**Template:** `agents/nextjs-dev-agent.md`

Spawn a general-purpose agent using the nextjs-dev-agent template.

## Workflow

### 1. Analyze

- Check existing auth setup (none, partial, or complete)
- Identify preferred auth strategy (NextAuth.js, Clerk, custom)
- Review database setup for user/session storage
- Check existing middleware configuration

### 2. Plan

- Choose auth providers (Credentials, Google, GitHub, etc.)
- Plan route protection strategy (middleware vs layout-level)
- Design session access pattern (Server Components vs Client Components)
- Determine auth-related API routes needed

### 3. Execute

- Install NextAuth.js: `npm install next-auth@beta @auth/core`
- Create auth configuration: `lib/auth.ts` with providers and callbacks
- Create auth API route: `app/api/auth/[...nextauth]/route.ts`
- Setup middleware for route protection: `middleware.ts`
- Create login/register pages if not present
- Add session provider to root layout
- Create auth utility functions (getCurrentUser, requireAuth)

### 4. Verify

- Ensure login/logout flow works
- Verify protected routes redirect unauthenticated users
- Confirm session is accessible in both Server and Client Components
- Check that auth state persists across page refreshes

## Output

- Auth configuration file with providers
- API route handler for NextAuth
- Middleware for route protection
- Login/register page templates
- Session provider in root layout
- Auth utility functions

## Examples

```
"Setup NextAuth with Google and Credentials providers"
# Creates: lib/auth.ts, app/api/auth/[...nextauth]/route.ts, middleware.ts
# Creates: app/(auth)/login/page.tsx, app/(auth)/register/page.tsx
# Updates: app/layout.tsx (adds SessionProvider)
```

## Error Handling

- **NextAuth version mismatch:** Ensure v5 (beta) is used with App Router
- **Database connection:** Verify DATABASE_URL is set and accessible
- **OAuth callback URL:** Ensure NEXTAUTH_URL matches the deployed domain
- **Session issues:** Check cookie settings (secure, sameSite) match environment
