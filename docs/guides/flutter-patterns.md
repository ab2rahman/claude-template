# Flutter Patterns Guide

## Project Structure

### Feature-First (Recommended)

```
lib/
├── app.dart                    # MaterialApp entry
├── core/                       # Shared across features
│   ├── constants/
│   ├── extensions/
│   ├── themes/
│   ├── utils/
│   └── widgets/                # Shared UI components
├── features/                   # Feature modules
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       └── widgets/
│   ├── home/
│   └── profile/
├── router/
│   └── app_router.dart
└── main.dart
```

### Layer-First (Alternative)

```
lib/
├── models/
├── providers/
├── screens/
├── services/
├── widgets/
└── main.dart
```

## State Management — Riverpod

### Provider Pattern

```dart
// Simple provider
final helloProvider = Provider<String>((ref) => 'Hello');

// StateNotifier provider
final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(),
);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state = state + 1;
  void decrement() => state = state - 1;
}
```

### AsyncNotifier Pattern

```dart
@riverpod
class UserProfile extends _$UserProfile {
  @override
  Future<User> build(String userId) {
    return _repository.getUser(userId);
  }

  Future<void> updateName(String name) async {
    state = const AsyncLoading();
    state = AsyncData(await _repository.updateName(name));
  }
}
```

### Consumer Widget Usage

```dart
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Text('$count');
  }
}
```

## Navigation — GoRouter

### Route Definition

```dart
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/profile/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProfileScreen(userId: id);
      },
    ),
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      ],
    ),
  ],
  redirect: (context, state) {
    final isLoggedIn = /* check auth */;
    if (!isLoggedIn && state.matchedLocation != '/login') return '/login';
    return null;
  },
);
```

### Navigation Calls

```dart
// Push route
context.go('/profile/123');
context.goNamed('profile', pathParameters: {'id': '123'});

// Push with query params
context.go('/search?q=hello&page=1');

// Pop
context.pop();
```

## Networking — Dio

### Setup

```dart
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.example.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  dio.interceptors.add(AuthInterceptor(ref));
  dio.interceptors.add(LogInterceptor());

  return dio;
});
```

### Repository Pattern

```dart
class AuthRepository {
  final Dio _dio;

  Future<User> login(String email, String password) async {
    final response = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return User.fromJson(response.data);
  }
}
```

## Widget Patterns

### Reusable Widget

```dart
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final ButtonStyle? style;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: style,
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(label),
    );
  }
}
```

### Form Pattern

```dart
class LoginForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ref.read(loginProvider.notifier).login(
          _emailController.text,
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            validator: (v) => v?.isEmpty == true ? 'Required' : null,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
          ),
          ElevatedButton(onPressed: _submit, child: const Text('Login')),
        ],
      ),
    );
  }
}
```

## Testing

### Widget Test

```dart
void main() {
  testWidgets('LoginScreen shows form', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: LoginScreen())),
    );

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
  });
}
```

### Unit Test with Riverpod

```dart
void main() {
  test('counter increments', () {
    final container = ProviderContainer();
    final notifier = container.read(counterProvider.notifier);

    notifier.increment();
    expect(container.read(counterProvider), 1);
  });
}
```

## Commands

| Command | Usage | Pattern |
|---------|-------|---------|
| `/flutter:test` | Run tests | 1 (bash) |
| `/flutter:build` | Build APK/IPA | 1 (bash) |
| `/flutter:clean` | Clean build | 1 (bash) |
| `/flutter:coverage` | Test coverage | 1 (bash) |
| `/flutter:screen` | Create screen | 3 (full) |
| `/flutter:provider` | Create provider | 2 (skill) |
| `/flutter:api` | Add API endpoint | 2 (skill) |
| `/flutter:nav` | Setup navigation | 2 (skill) |
| `/flutter:form` | Add form validation | 2 (skill) |
| `/flutter:widget-test` | Generate widget test | 2 (skill) |
| `/flutter:lint` | Run linter | 1 (bash) |
