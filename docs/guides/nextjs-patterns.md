# Next.js Patterns Guide

## Project Structure

### App Router (Recommended)

```
src/
├── app/
│   ├── layout.tsx              # Root layout
│   ├── page.tsx                # Home page
│   ├── loading.tsx             # Global loading
│   ├── error.tsx               # Global error
│   ├── not-found.tsx
│   ├── (auth)/
│   │   ├── layout.tsx          # Auth layout (no nav)
│   │   ├── login/
│   │   │   └── page.tsx
│   │   └── register/
│   │       └── page.tsx
│   ├── (dashboard)/
│   │   ├── layout.tsx          # Dashboard layout (with sidebar)
│   │   ├── dashboard/
│   │   │   └── page.tsx
│   │   └── settings/
│   │       └── page.tsx
│   └── api/
│       ├── auth/
│       │   └── route.ts
│       └── users/
│           └── route.ts
├── components/
│   ├── ui/                     # Shadcn/ui primitives
│   ├── forms/
│   └── layouts/
├── lib/
│   ├── auth.ts
│   ├── db.ts                   # Prisma/Drizzle client
│   └── utils.ts
├── hooks/
│   └── useDebounce.ts
├── types/
│   └── index.ts
└── actions/                    # Server Actions
    ├── auth.ts
    └── users.ts
```

## Server vs Client Components

### Server Component (Default)

```typescript
// app/dashboard/page.tsx — no "use client" needed
import { db } from '@/lib/db';

export default async function DashboardPage() {
  const stats = await db.query.stats.findMany();

  return (
    <div>
      <h1>Dashboard</h1>
      <StatsGrid stats={stats} />
    </div>
  );
}
```

### Client Component

```typescript
'use client';

import { useState } from 'react';

export function SearchInput({ onSearch }: { onSearch: (q: string) => void }) {
  const [query, setQuery] = useState('');

  return (
    <input
      value={query}
      onChange={(e) => {
        setQuery(e.target.value);
        onSearch(e.target.value);
      }}
      placeholder="Search..."
    />
  );
}
```

## Data Fetching Strategies

### Server Component (Recommended)

```typescript
export default async function ProductsPage() {
  const products = await fetch('https://api.example.com/products', {
    next: { revalidate: 3600 }, // ISR: revalidate every hour
  }).then((r) => r.json());

  return <ProductList products={products} />;
}
```

### On-Demand Revalidation

```typescript
import { revalidateTag } from 'next/cache';

export async function POST(request: Request) {
  const payload = await request.json();

  // Update data...
  revalidateTag('products');

  return Response.json({ success: true });
}
```

### Client-Side with React Query

```typescript
'use client';

import { useQuery } from '@tanstack/react-query';

export function useProducts() {
  return useQuery({
    queryKey: ['products'],
    queryFn: () => fetch('/api/products').then((r) => r.json()),
  });
}
```

## Server Actions

### Form Action

```typescript
// actions/auth.ts
'use server';

import { redirect } from 'next/navigation';
import { loginSchema } from '@/lib/validations';

export async function login(formData: FormData) {
  const raw = {
    email: formData.get('email') as string,
    password: formData.get('password') as string,
  };

  const data = loginSchema.parse(raw);

  // Authenticate user
  const user = await authenticateUser(data.email, data.password);
  if (!user) return { error: 'Invalid credentials' };

  // Set session
  await setSession(user.id);
  redirect('/dashboard');
}
```

### Usage in Component

```typescript
import { login } from '@/actions/auth';

export function LoginForm() {
  return (
    <form action={login}>
      <input name="email" type="email" required />
      <input name="password" type="password" required />
      <button type="submit">Login</button>
    </form>
  );
}
```

## Route Handlers

```typescript
// app/api/users/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { db } from '@/lib/db';

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url);
  const page = Number(searchParams.get('page')) || 1;
  const limit = Number(searchParams.get('limit')) || 10;

  const users = await db.query.users.findMany({
    limit,
    offset: (page - 1) * limit,
  });

  return NextResponse.json({ data: users, page, limit });
}

export async function POST(request: NextRequest) {
  const body = await request.json();
  const user = await db.insert(users).values(body).returning();

  return NextResponse.json({ data: user }, { status: 201 });
}
```

## Authentication — NextAuth.js v5

```typescript
// lib/auth.ts
import NextAuth from 'next-auth';
import Credentials from 'next-auth/providers/credentials';
import { db } from '@/lib/db';

export const { handlers, signIn, signOut, auth } = NextAuth({
  providers: [
    Credentials({
      credentials: {
        email: { label: 'Email', type: 'email' },
        password: { label: 'Password', type: 'password' },
      },
      async authorize(credentials) {
        const user = await verifyCredentials(credentials);
        return user;
      },
    }),
  ],
  pages: {
    signIn: '/login',
  },
});
```

### Middleware Protection

```typescript
// middleware.ts
import { auth } from '@/lib/auth';

export default auth((req) => {
  const { pathname } = req.nextUrl;
  const isLoggedIn = !!req.auth;

  if (!isLoggedIn && pathname.startsWith('/dashboard')) {
    return Response.redirect(new URL('/login', req.url));
  }
});

export const config = {
  matcher: ['/((?!api|_next/static|_next/image|.*\\.png$).*)'],
};
```

## SEO & Metadata

```typescript
// app/products/[id]/page.tsx
import { Metadata } from 'next';

export async function generateMetadata({
  params,
}: {
  params: { id: string };
}): Promise<Metadata> {
  const product = await getProduct(params.id);

  return {
    title: product.name,
    description: product.description,
    openGraph: {
      title: product.name,
      description: product.description,
      images: [product.image],
    },
  };
}

export default function ProductPage({ params }: { params: { id: string } }) {
  // ...
}
```

## Testing

### Page Test

```typescript
import { render, screen } from '@testing-library/react';
import HomePage from './page';

describe('HomePage', () => {
  it('renders heading', () => {
    render(<HomePage />);
    expect(screen.getByRole('heading')).toBeInTheDocument();
  });
});
```

## Commands

| Command | Usage | Pattern |
|---------|-------|---------|
| `/nextjs:build` | Build project | 1 (bash) |
| `/nextjs:test` | Run tests | 1 (bash) |
| `/nextjs:page` | Create page | 3 (full) |
| `/nextjs:component` | Create component | 2 (skill) |
| `/nextjs:api` | Create API route | 2 (skill) |
| `/nextjs:layout` | Create layout | 2 (skill) |
| `/nextjs:state` | Setup state management | 2 (skill) |
| `/nextjs:lint` | Run linter | 1 (bash) |
