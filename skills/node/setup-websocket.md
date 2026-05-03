---
name: "Setup WebSocket"
description: "Integrates Socket.io or native WebSocket support into an existing Node.js server."
category: "node"
---

# Setup WebSocket

## Overview

Adds real-time WebSocket communication to an existing Node.js server using Socket.io (recommended) or the native `ws` library. Sets up connection handling, event routing, room management, and authentication middleware.

## Trigger

- Direct request: "add websocket", "setup socket.io", "real-time communication"
- When building chat, notifications, or live-update features

## Prerequisites

- Existing Node.js HTTP/Express server
- `socket.io` or `ws` package available or ready to install
- Authentication mechanism in place (for socket auth)

## Agent

**Template:** `agents/node-dev-agent.md`

Spawn a general-purpose agent using the node-dev-agent template.

## Workflow

### 1. Analyze

- Check existing server setup (Express, Fastify, HTTP server)
- Identify the socket library preference or default to Socket.io
- Review authentication mechanism for socket connection auth
- Check existing project structure for where to place socket handlers

### 2. Plan

- Determine event naming conventions
- Plan room/namespace structure based on features needed
- Design authentication middleware for socket connections
- Map out the event flow (connect -> authenticate -> join room -> exchange events)

### 3. Execute

- Install Socket.io: `npm install socket.io`
- Create socket setup file: `src/sockets/socket.setup.ts`
- Create authentication middleware for socket connections
- Create event handlers: `src/sockets/handlers/{feature}.handler.ts`
- Integrate socket.io with existing HTTP server
- Add CORS configuration for socket connections

### 4. Verify

- Ensure server starts without errors
- Test socket connection with a client tool
- Verify authentication middleware blocks unauthenticated connections
- Confirm events are received in correct rooms

## Output

- Socket.io server setup attached to HTTP server
- Authentication middleware for socket connections
- Event handler files with typed event interfaces
- Client-side connection example

## Examples

```
"Setup Socket.io for a chat feature"
# Creates: src/sockets/socket.setup.ts
# Creates: src/sockets/handlers/chat.handler.ts
# Updates: src/server.ts (attaches socket.io to HTTP server)
```

## Error Handling

- **Port conflict:** Suggest using the same port as HTTP server (Socket.io attaches to it)
- **CORS issues:** Configure socket.io CORS to match the allowed origins
- **Auth failures:** Provide clear error events when authentication fails
