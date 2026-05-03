# iOS/Swift Patterns Guide

## Project Structure

```
App/
├── App/
│   ├── AppApp.swift            # @main entry point
│   ├── ContentView.swift
│   └── AppDelegate.swift
├── Core/
│   ├── Extensions/
│   ├── Protocols/
│   └── Utilities/
├── Features/
│   ├── Auth/
│   │   ├── Views/
│   │   │   └── LoginView.swift
│   │   ├── ViewModels/
│   │   │   └── LoginViewModel.swift
│   │   └── Models/
│   │       └── User.swift
│   ├── Home/
│   └── Profile/
├── Services/
│   ├── Network/
│   │   ├── APIClient.swift
│   │   └── Endpoints/
│   ├── Persistence/
│   │   └── CoreDataStack.swift
│   └── Auth/
│       └── AuthManager.swift
├── Resources/
│   ├── Assets.xcassets
│   └── Localization/
└── Dependencies/
    └── Container.swift
```

## Architecture — MVVM with @Observable

### ViewModel

```swift
@Observable
@MainActor
final class LoginViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?

    private let authManager: AuthManager

    init(authManager: AuthManager) {
        self.authManager = authManager
    }

    func login() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "All fields required"
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            try await authManager.login(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
```

### View (SwiftUI)

```swift
struct LoginView: View {
    @State private var viewModel: LoginViewModel

    init(authManager: AuthManager) {
        _viewModel = State(wrappedValue: LoginViewModel(authManager: authManager))
    }

    var body: some View {
        Form {
            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)

            SecureField("Password", text: $viewModel.password)

            if let error = viewModel.errorMessage {
                Text(error).foregroundStyle(.red)
            }

            Button("Login") {
                Task { await viewModel.login() }
            }
            .disabled(viewModel.isLoading)
        }
    }
}
```

## Networking — URLSession

### API Client

```swift
actor APIClient {
    static let shared = APIClient()

    private let baseURL = URL(string: "https://api.example.com")!

    func request<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Encodable? = nil
    ) async throws -> T {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(endpoint))
        urlRequest.httpMethod = method
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
```

### Endpoint Pattern

```swift
enum APIEndpoint {
    case login(email: String, password: String)
    case profile(userId: String)
    case updateProfile(userId: String, data: UpdateProfileDTO)

    var path: String {
        switch self {
        case .login: return "/auth/login"
        case .profile(let id): return "/users/\(id)"
        case .updateProfile(let id, _): return "/users/\(id)"
        }
    }
}
```

## Persistence — CoreData

### Model Setup

```swift
@MainActor
final class CoreDataStack {
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "AppModel")
        container.loadPersistentStores { _, error in
            if let error { fatalError("CoreData error: \(error)") }
        }
    }

    var context: NSManagedObjectContext { container.viewContext }
}
```

### Fetching with Swift Concurrency

```swift
extension CoreDataStack {
    func fetchUsers() async throws -> [UserEntity] {
        let request = UserEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \UserEntity.name, ascending: true)]
        return try context.fetch(request)
    }

    func saveUser(name: String, email: String) throws {
        let user = UserEntity(context: context)
        user.id = UUID()
        user.name = name
        user.email = email
        try context.save()
    }
}
```

## Navigation — SwiftUI NavigationStack

```swift
@Observable
final class NavigationManager {
    var path = NavigationPath()

    func navigate(to route: AppRoute) {
        path.append(route)
    }

    func goBack() {
        path.removeLast()
    }

    func goRoot() {
        path = NavigationPath()
    }
}

enum AppRoute: Hashable {
    case profile(userId: String)
    case settings
    case productDetail(productId: String)
}

struct AppView: View {
    @State private var navManager = NavigationManager()

    var body: some View {
        NavigationStack(path: $navManager.path) {
            HomeView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .profile(let id): ProfileView(userId: id)
                    case .settings: SettingsView()
                    case .productDetail(let id): ProductDetailView(productId: id)
                    }
                }
        }
        .environment(navManager)
    }
}
```

## Dependency Injection

```swift
// Using @Environment
@MainActor
@Observable
final class AppDependencies {
    let authManager: AuthManager
    let apiClient: APIClient
    let coreData: CoreDataStack

    init() {
        self.apiClient = APIClient.shared
        self.authManager = AuthManager(apiClient: apiClient)
        self.coreData = CoreDataStack()
    }
}

// In App
@main
struct MyApp: App {
    @State private var dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dependencies)
        }
    }
}

// Usage in views
struct SomeView: View {
    @Environment(AppDependencies.self) var dependencies
}
```

## Testing

### ViewModel Test

```swift
@Test func loginSuccessUpdatesState() async {
    let viewModel = LoginViewModel(authManager: MockAuthManager())
    viewModel.email = "test@test.com"
    viewModel.password = "password"

    await viewModel.login()

    #expect(viewModel.errorMessage == nil)
}
```

## Commands

| Command | Usage | Pattern |
|---------|-------|---------|
| `/ios:build` | Build project | 1 (bash) |
| `/ios:test` | Run tests | 1 (bash) |
| `/ios:screen` | Create screen | 3 (full) |
| `/ios:viewmodel` | Create ViewModel | 2 (skill) |
| `/ios:api` | Add API endpoint | 2 (skill) |
| `/ios:nav` | Setup navigation | 2 (skill) |
| `/ios:coredata` | Setup CoreData | 2 (skill) |
