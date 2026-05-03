# Node.js Patterns Guide

## Project Structure

### Layered Architecture (Recommended)

```
src/
├── config/
│   ├── database.ts
│   ├── env.ts
│   └── redis.ts
├── middleware/
│   ├── auth.ts
│   ├── errorHandler.ts
│   ├── rateLimiter.ts
│   ├── requestLogger.ts
│   └── validate.ts
├── modules/
│   ├── auth/
│   │   ├── auth.controller.ts
│   │   ├── auth.service.ts
│   │   ├── auth.repository.ts
│   │   ├── auth.routes.ts
│   │   ├── auth.types.ts
│   │   └── __tests__/
│   │       └── auth.service.test.ts
│   ├── users/
│   └── products/
├── shared/
│   ├── errors/
│   │   ├── AppError.ts
│   │   └── errorTypes.ts
│   ├── types/
│   │   └── express.d.ts
│   └── utils/
│       ├── logger.ts
│       └── pagination.ts
├── app.ts
└── server.ts
```

## Express Setup

### App Factory

```typescript
import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import { requestLogger } from './middleware/requestLogger';
import { errorHandler } from './middleware/errorHandler';
import { authRouter } from './modules/auth/auth.routes';
import { userRouter } from './modules/users/user.routes';

export function createApp() {
  const app = express();

  // Global middleware
  app.use(helmet());
  app.use(cors());
  app.use(express.json({ limit: '10mb' }));
  app.use(requestLogger);

  // Health check
  app.get('/health', (_, res) => res.json({ status: 'ok' }));

  // Routes
  app.use('/api/auth', authRouter);
  app.use('/api/users', userRouter);

  // Error handling (must be last)
  app.use(errorHandler);

  return app;
}
```

## Layered Pattern

### Route

```typescript
import { Router } from 'express';
import { authController } from './auth.controller';
import { validate } from '../../middleware/validate';
import { loginSchema, registerSchema } from './auth.types';

const router = Router();

router.post('/register', validate(registerSchema), authController.register);
router.post('/login', validate(loginSchema), authController.login);
router.post('/refresh', authController.refreshToken);
router.post('/logout', authenticate, authController.logout);

export { router as authRouter };
```

### Controller

```typescript
import { Request, Response, NextFunction } from 'express';
import { AuthService } from './auth.service';
import { AppError } from '../../shared/errors/AppError';

export const authController = {
  async register(req: Request, res: Response, next: NextFunction) {
    try {
      const result = await AuthService.register(req.body);
      res.status(201).json({ success: true, data: result });
    } catch (error) {
      next(error);
    }
  },

  async login(req: Request, res: Response, next: NextFunction) {
    try {
      const { email, password } = req.body;
      const result = await AuthService.login(email, password);
      res.json({ success: true, data: result });
    } catch (error) {
      next(error);
    }
  },
};
```

### Service

```typescript
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { AuthRepository } from './auth.repository';
import { AppError } from '../../shared/errors/AppError';
import { env } from '../../config/env';

export const AuthService = {
  async register(data: RegisterDTO) {
    const existing = await AuthRepository.findByEmail(data.email);
    if (existing) throw new AppError(409, 'Email already registered');

    const hashedPassword = await bcrypt.hash(data.password, 12);
    const user = await AuthRepository.create({ ...data, password: hashedPassword });

    const token = generateToken(user.id);
    return { user: sanitizeUser(user), token };
  },

  async login(email: string, password: string) {
    const user = await AuthRepository.findByEmail(email);
    if (!user) throw new AppError(401, 'Invalid credentials');

    const valid = await bcrypt.compare(password, user.password);
    if (!valid) throw new AppError(401, 'Invalid credentials');

    const token = generateToken(user.id);
    return { user: sanitizeUser(user), token };
  },
};
```

### Repository

```typescript
import { prisma } from '../../config/database';
import { Prisma } from '@prisma/client';

export const AuthRepository = {
  findByEmail(email: string) {
    return prisma.user.findUnique({ where: { email } });
  },

  findById(id: string) {
    return prisma.user.findUnique({ where: { id } });
  },

  create(data: Prisma.UserCreateInput) {
    return prisma.user.create({ data });
  },
};
```

## Validation — Zod

```typescript
import { z } from 'zod';

export const registerSchema = z.object({
  body: z.object({
    name: z.string().min(2).max(100),
    email: z.string().email(),
    password: z.string().min(8).max(100),
  }),
});

export const loginSchema = z.object({
  body: z.object({
    email: z.string().email(),
    password: z.string(),
  }),
});

export type RegisterDTO = z.infer<typeof registerSchema>['body'];
export type LoginDTO = z.infer<typeof loginSchema>['body'];
```

### Validation Middleware

```typescript
import { Request, Response, NextFunction } from 'express';
import { ZodSchema } from 'zod';

export function validate(schema: ZodSchema) {
  return (req: Request, res: Response, next: NextFunction) => {
    const result = schema.safeParse({ body: req.body, params: req.params, query: req.query });
    if (!result.success) {
      return res.status(400).json({
        success: false,
        errors: result.error.flatten(),
      });
    }
    req.body = result.data.body;
    next();
  };
}
```

## Authentication — JWT

```typescript
import jwt from 'jsonwebtoken';
import { env } from '../config/env';

export function generateToken(userId: string): string {
  return jwt.sign({ sub: userId }, env.JWT_SECRET, { expiresIn: '15m' });
}

export function generateRefreshToken(userId: string): string {
  return jwt.sign({ sub: userId }, env.JWT_REFRESH_SECRET, { expiresIn: '7d' });
}

export function verifyToken(token: string): { sub: string } {
  return jwt.verify(token, env.JWT_SECRET) as { sub: string };
}
```

### Auth Middleware

```typescript
import { Request, Response, NextFunction } from 'express';
import { verifyToken } from '../utils/jwt';
import { AppError } from '../shared/errors/AppError';

export function authenticate(req: Request, _res: Response, next: NextFunction) {
  const header = req.headers.authorization;
  if (!header?.startsWith('Bearer ')) {
    throw new AppError(401, 'Missing auth token');
  }

  try {
    const payload = verifyToken(header.split(' ')[1]);
    req.user = { id: payload.sub };
    next();
  } catch {
    throw new AppError(401, 'Invalid or expired token');
  }
}
```

## Error Handling

```typescript
export class AppError extends Error {
  constructor(
    public statusCode: number,
    message: string,
  ) {
    super(message);
    this.name = 'AppError';
  }
}

export function errorHandler(err: Error, req: Request, res: Response, _next: NextFunction) {
  const statusCode = err instanceof AppError ? err.statusCode : 500;
  const message = err instanceof AppError ? err.message : 'Internal server error';

  if (statusCode === 500) {
    logger.error(err);
  }

  res.status(statusCode).json({
    success: false,
    message,
  });
}
```

## Testing

### Service Test

```typescript
import { AuthService } from './auth.service';
import { AuthRepository } from './auth.repository';

jest.mock('./auth.repository');
jest.mock('bcryptjs');
jest.mock('jsonwebtoken');

describe('AuthService', () => {
  it('should register a new user', async () => {
    (AuthRepository.findByEmail as jest.Mock).mockResolvedValue(null);
    (AuthRepository.create as jest.Mock).mockResolvedValue({ id: '1', name: 'Test', email: 'test@test.com' });

    const result = await AuthService.register({
      name: 'Test',
      email: 'test@test.com',
      password: 'password123',
    });

    expect(result).toHaveProperty('token');
    expect(result.user).toBeDefined();
  });
});
```

## Commands

| Command | Usage | Pattern |
|---------|-------|---------|
| `/node:build` | Build project | 1 (bash) |
| `/node:test` | Run tests | 1 (bash) |
| `/node:route` | Create route | 3 (full) |
| `/node:middleware` | Create middleware | 2 (skill) |
| `/node:model` | Create data model | 2 (skill) |
| `/node:api-docs` | Generate API docs | 2 (skill) |
| `/node:lint` | Run linter | 1 (bash) |
