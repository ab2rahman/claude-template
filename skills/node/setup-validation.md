---
name: "Setup Request Validation"
description: "Adds Zod or Joi request validation middleware to an existing Node.js route."
category: "node"
---

# Setup Request Validation

## Overview

Adds input validation to an existing Node.js route using Zod or Joi. Creates validation schemas for request body, query parameters, and route params, then wires them into the route via validation middleware.

## Trigger

- Direct request: "add validation to route", "validate request body", "setup input validation"
- After creating a route via `/node:route`

## Prerequisites

- Existing Node.js project with Express or Fastify
- At least one route file already created
- Zod or Joi available in dependencies

## Agent

**Template:** `agents/node-dev-agent.md`

Spawn a general-purpose agent using the node-dev-agent template.

## Workflow

### 1. Analyze

- Check which validation library is used (Zod, Joi, or none)
- Review existing route files for request shapes (body, query, params)
- Check if validation middleware already exists

### 2. Plan

- Identify fields that need validation for each endpoint
- Determine validation rules (required, type, min/max, email format, etc.)
- Plan schema file location alongside the route

### 3. Execute

- Install validation library if not present (`npm install zod`)
- Create validation schema file: `src/validations/{resource}.validation.ts`
- Define schemas for body, query, and params
- Create or update validation middleware to use the schemas
- Apply middleware to route handlers

### 4. Verify

- Ensure TypeScript compiles without errors
- Test validation with valid and invalid payloads
- Confirm error response format matches project conventions

## Output

- Validation schema file with Zod/Joi definitions
- Updated validation middleware
- Route handlers with validation applied

## Examples

```
"Add validation to the users route"
# Creates: src/validations/user.validation.ts
# Updates: src/routes/user.routes.ts (adds validation middleware)
```

## Error Handling

- **No validation library found:** Install Zod as default and document the choice
- **Existing validation:** Extend existing schemas rather than replacing them
- **Complex nested objects:** Use Zod's `.nested()` or recursive schemas
