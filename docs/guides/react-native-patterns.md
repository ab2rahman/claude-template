# React Native Patterns Guide

## Project Structure

### Expo (Recommended)

```
src/
├── app/                        # Expo Router screens
│   ├── _layout.tsx             # Root layout
│   ├── index.tsx               # Home screen
│   ├── (auth)/
│   │   ├── _layout.tsx
│   │   ├── login.tsx
│   │   └── register.tsx
│   └── (tabs)/
│       ├── _layout.tsx
│       ├── home.tsx
│       └── profile.tsx
├── components/
│   ├── ui/                     # Primitives (Button, Input, Card)
│   └── forms/                  # Form components
├── hooks/
│   ├── useAuth.ts
│   └── useTheme.ts
├── stores/
│   ├── authStore.ts
│   └── cartStore.ts
├── services/
│   ├── api.ts                  # Axios/fetch setup
│   └── storage.ts
├── types/
│   └── index.ts
├── utils/
│   ├── format.ts
│   └── validation.ts
└── constants/
    ├── colors.ts
    └── spacing.ts
```

## State Management — Zustand

### Store Definition

```typescript
import { create } from 'zustand';
import { persist } from 'zustand/middleware';

interface User {
  id: string;
  name: string;
  email: string;
}

interface AuthState {
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      user: null,
      token: null,
      isAuthenticated: false,

      login: async (email, password) => {
        const response = await api.post('/auth/login', { email, password });
        set({
          user: response.data.user,
          token: response.data.token,
          isAuthenticated: true,
        });
      },

      logout: () => set({ user: null, token: null, isAuthenticated: false }),
    }),
    { name: 'auth-storage' },
  ),
);
```

### Server State — React Query

```typescript
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';

export function useUser(userId: string) {
  return useQuery({
    queryKey: ['user', userId],
    queryFn: () => api.get(`/users/${userId}`).then((r) => r.data),
    enabled: !!userId,
  });
}

export function useUpdateUser() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (data: UpdateUserDTO) => api.patch('/user/profile', data),
    onSuccess: (_, variables) => {
      queryClient.invalidateQueries({ queryKey: ['user', variables.id] });
    },
  });
}
```

## Navigation — Expo Router

### File-Based Routing

```
app/
├── _layout.tsx              # Root layout with providers
├── index.tsx                # Redirects to /(tabs)/home
├── (auth)/
│   ├── _layout.tsx          # Auth stack (no tabs)
│   ├── login.tsx            # /login
│   └── register.tsx         # /register
└── (tabs)/
    ├── _layout.tsx          # Bottom tab navigation
    ├── home.tsx             # /home
    ├── profile.tsx          # /profile
    └── settings.tsx         # /settings
```

### Layout Example

```typescript
// app/_layout.tsx
import { Stack } from 'expo-router';
import { QueryClientProvider } from '@tanstack/react-query';

export default function RootLayout() {
  return (
    <QueryClientProvider client={queryClient}>
      <Stack screenOptions={{ headerShown: false }}>
        <Stack.Screen name="(auth)" />
        <Stack.Screen name="(tabs)" />
      </Stack>
    </QueryClientProvider>
  );
}
```

### Navigation Calls

```typescript
import { router } from 'expo-router';

// Navigate
router.push('/profile');
router.replace('/home');

// With params
router.push({ pathname: '/user/[id]', params: { id: '123' } });

// Back
router.back();
```

## API Layer

### Axios Setup

```typescript
import axios from 'axios';
import { useAuthStore } from '@/stores/authStore';

export const api = axios.create({
  baseURL: process.env.EXPO_PUBLIC_API_URL,
  timeout: 10000,
});

api.interceptors.request.use((config) => {
  const token = useAuthStore.getState().token;
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

api.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (error.response?.status === 401) {
      useAuthStore.getState().logout();
      router.replace('/login');
    }
    return Promise.reject(error);
  },
);
```

## Component Patterns

### Reusable Button

```typescript
import { Pressable, Text, StyleSheet, ActivityIndicator } from 'react-native';

interface ButtonProps {
  label: string;
  onPress: () => void;
  variant?: 'primary' | 'secondary' | 'outline';
  loading?: boolean;
  disabled?: boolean;
}

export function Button({
  label,
  onPress,
  variant = 'primary',
  loading = false,
  disabled = false,
}: ButtonProps) {
  return (
    <Pressable
      onPress={onPress}
      disabled={disabled || loading}
      style={[styles.base, styles[variant]]}
    >
      {loading ? (
        <ActivityIndicator color="#fff" />
      ) : (
        <Text style={styles.text}>{label}</Text>
      )}
    </Pressable>
  );
}

const styles = StyleSheet.create({
  base: { paddingVertical: 12, paddingHorizontal: 24, borderRadius: 8, alignItems: 'center' },
  primary: { backgroundColor: '#007AFF' },
  secondary: { backgroundColor: '#6c757d' },
  outline: { borderWidth: 1, borderColor: '#007AFF' },
  text: { color: '#fff', fontSize: 16, fontWeight: '600' },
});
```

### Custom Hook

```typescript
export function useTheme() {
  const colorScheme = useColorScheme();
  const isDark = colorScheme === 'dark';

  return {
    isDark,
    colors: isDark ? darkColors : lightColors,
    spacing: SPACING,
  };
}
```

## Testing

### Component Test

```typescript
import { render, fireEvent } from '@testing-library/react-native';
import { Button } from './Button';

describe('Button', () => {
  it('calls onPress when tapped', () => {
    const onPress = jest.fn();
    const { getByText } = render(<Button label="Submit" onPress={onPress} />);

    fireEvent.press(getByText('Submit'));
    expect(onPress).toHaveBeenCalled();
  });

  it('shows loading indicator', () => {
    const { getByA11yLabel } = render(
      <Button label="Submit" onPress={() => {}} loading />,
    );
    // loading indicator visible
  });
});
```

## Commands

| Command | Usage | Pattern |
|---------|-------|---------|
| `/react-native:build` | Build app | 1 (bash) |
| `/react-native:test` | Run tests | 1 (bash) |
| `/react-native:screen` | Create screen | 3 (full) |
| `/react-native:component` | Create component | 2 (skill) |
| `/react-native:api` | Add API endpoint | 2 (skill) |
| `/react-native:nav` | Setup navigation | 2 (skill) |
| `/react-native:state` | Setup state management | 2 (skill) |
| `/react-native:lint` | Run linter | 1 (bash) |
