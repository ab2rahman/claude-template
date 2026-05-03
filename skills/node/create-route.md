---
name: "Create Node.js Route"
description: "Creates a full layered route with Router, Controller, Service, and Repository layers following clean architecture."
category: "node"
---

## Overview

Scaffolds a complete Node.js route following the Router → Controller → Service → Repository pattern. Each layer has a single responsibility and the route is registered automatically.

## Trigger

- `/node:create-route "<resource>"` — e.g., `/node:create-route "users"`
- Spawning agent with task: "Create a new route for <resource>"

## Prerequisites

- Existing Node.js project with Express (or compatible framework)
- Project follows layered architecture conventions
- Agent template: `agents/node-dev-agent.md`

## Agent

Spawn a general-purpose agent using the `agents/node-dev-agent.md` template with the following task context:

```
Resource: {resource_name}
Base path: {project_src_path}
```

## Workflow

### 1. Analyze
- Check existing route patterns in `src/routes/` or `src/modules/`
- Identify framework (Express, Fastify, etc.)
- Review existing conventions for naming, folder structure, and middleware usage

### 2. Plan
- Map out the CRUD endpoints needed for the resource
- Identify validation rules and middleware requirements
- Determine database/ORM patterns from existing repositories

### 3. Execute
- Create route file: `src/routes/{resource}.routes.ts` — define endpoints and attach middleware
- Create controller: `src/controllers/{resource}.controller.ts` — handle request/response
- Create service: `src/services/{resource}.service.ts` — business logic layer
- Create repository: `src/repositories/{resource}.repository.ts` — data access layer
- Add validation schema using Joi or Zod
- Register route in the main router file (e.g., `src/routes/index.ts`)

### 4. Verify
- Ensure all imports resolve correctly
- Confirm the route is registered and accessible
- Check that TypeScript compiles without errors
- Validate the layered pattern is consistent with existing code

## Output

- Route file with CRUD endpoints
- Controller with request handling
- Service with business logic
- Repository with data access
- Validation schema applied to routes
- Route registered in main router

## Examples

```
/node:create-route "products"
# Creates: routes/products.routes.ts, controllers/products.controller.ts,
#          services/products.service.ts, repositories/products.repository.ts
```

## Error Handling

- If layered pattern doesn't exist, create the folder structure and document the convention
- If framework is unsupported, default to Express and note the limitation
- If route already exists, suggest extending the existing route instead of creating a duplicate
