# Kotlin/Android Patterns Guide

## Project Structure

```
app/src/main/java/com/example/app/
├── di/                         # Hilt modules
│   ├── AppModule.kt
│   ├── NetworkModule.kt
│   └── DatabaseModule.kt
├── data/
│   ├── local/
│   │   ├── db/
│   │   │   ├── AppDatabase.kt
│   │   │   ├── dao/
│   │   │   └── entity/
│   │   └── datastore/
│   ├── remote/
│   │   ├── api/
│   │   │   └── AuthApi.kt
│   │   ├── dto/
│   │   └── interceptor/
│   └── repository/
│       └── AuthRepositoryImpl.kt
├── domain/
│   ├── model/
│   ├── repository/
│   │   └── AuthRepository.kt
│   └── usecase/
│       └── LoginUseCase.kt
├── ui/
│   ├── theme/
│   │   ├── Theme.kt
│   │   ├── Color.kt
│   │   └── Type.kt
│   ├── navigation/
│   │   └── AppNavigation.kt
│   ├── screens/
│   │   ├── login/
│   │   │   ├── LoginScreen.kt
│   │   │   └── LoginViewModel.kt
│   │   └── home/
│   │       ├── HomeScreen.kt
│   │       └── HomeViewModel.kt
│   └── components/
│       └── AppButton.kt
└── MainActivity.kt
```

## Architecture — MVVM with StateFlow

### ViewModel

```kotlin
@HiltViewModel
class LoginViewModel @Inject constructor(
    private val loginUseCase: LoginUseCase,
) : ViewModel() {

    private val _uiState = MutableStateFlow<LoginUiState>(LoginUiState.Idle)
    val uiState: StateFlow<LoginUiState> = _uiState.asStateFlow()

    fun login(email: String, password: String) {
        viewModelScope.launch {
            _uiState.value = LoginUiState.Loading
            loginUseCase(email, password)
                .onSuccess { _uiState.value = LoginUiState.Success(it) }
                .onFailure { _uiState.value = LoginUiState.Error(it.message ?: "Unknown error") }
        }
    }
}

sealed interface LoginUiState {
    data object Idle : LoginUiState
    data object Loading : LoginUiState
    data class Success(val user: User) : LoginUiState
    data class Error(val message: String) : LoginUiState
}
```

### Screen (Jetpack Compose)

```kotlin
@Composable
fun LoginScreen(
    viewModel: LoginViewModel = hiltViewModel(),
    onLoginSuccess: () -> Unit,
) {
    val uiState by viewModel.uiState.collectAsStateWithLifecycle()

    LaunchedEffect(uiState) {
        if (uiState is LoginUiState.Success) onLoginSuccess()
    }

    when (val state = uiState) {
        is LoginUiState.Idle -> LoginForm(onSubmit = { email, pass ->
            viewModel.login(email, pass)
        })
        is LoginUiState.Loading -> CircularProgressIndicator()
        is LoginUiState.Error -> {
            LoginForm(onSubmit = { email, pass -> viewModel.login(email, pass) })
            Text(state.message, color = MaterialTheme.colorScheme.error)
        }
        is LoginUiState.Success -> { /* handled by LaunchedEffect */ }
    }
}
```

## Dependency Injection — Hilt

### Module

```kotlin
@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {

    @Provides
    @Singleton
    fun provideOkHttpClient(): OkHttpClient = OkHttpClient.Builder()
        .addInterceptor(AuthInterceptor())
        .addInterceptor(HttpLoggingInterceptor().apply {
            level = HttpLoggingInterceptor.Level.BODY
        })
        .build()

    @Provides
    @Singleton
    fun provideRetrofit(client: OkHttpClient): Retrofit = Retrofit.Builder()
        .baseUrl("https://api.example.com")
        .client(client)
        .addConverterFactory(MoshiConverterFactory.create())
        .build()

    @Provides
    @Singleton
    fun provideAuthApi(retrofit: Retrofit): AuthApi =
        retrofit.create(AuthApi::class.java)
}
```

## Networking — Retrofit

### API Interface

```kotlin
interface AuthApi {
    @POST("auth/login")
    suspend fun login(@Body request: LoginRequest): Response<LoginResponse>

    @GET("user/profile")
    suspend fun getProfile(): Response<UserResponse>
}

data class LoginRequest(val email: String, val password: String)
data class LoginResponse(val token: String, val user: UserDto)
```

### Repository Implementation

```kotlin
class AuthRepositoryImpl @Inject constructor(
    private val api: AuthApi,
    private val userDao: UserDao,
) : AuthRepository {

    override suspend fun login(email: String, password: String): Result<User> = runCatching {
        val response = api.login(LoginRequest(email, password))
        if (response.isSuccessful) {
            val body = response.body()!!
            userDao.insert(body.user.toEntity())
            body.user.toDomain()
        } else {
            throw Exception(response.message())
        }
    }
}
```

## Database — Room

### Entity & DAO

```kotlin
@Entity(tableName = "users")
data class UserEntity(
    @PrimaryKey val id: String,
    val name: String,
    val email: String,
    val createdAt: Long = System.currentTimeMillis(),
)

@Dao
interface UserDao {
    @Query("SELECT * FROM users WHERE id = :id")
    suspend fun getUser(id: String): UserEntity?

    @Upsert
    suspend fun upsert(user: UserEntity)

    @Query("DELETE FROM users WHERE id = :id")
    suspend fun delete(id: String)
}
```

### Database

```kotlin
@Database(entities = [UserEntity::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun userDao(): UserDao
}
```

## Navigation — Compose Navigation

```kotlin
@Composable
fun AppNavigation() {
    val navController = rememberNavController()

    NavHost(navController = navController, startDestination = "login") {
        composable("login") {
            LoginScreen(onLoginSuccess = {
                navController.navigate("home") {
                    popUpTo("login") { inclusive = true }
                }
            })
        }
        composable(
            route = "profile/{userId}",
            arguments = listOf(navArgument("userId") { type = NavType.StringType }),
        ) { backStackEntry ->
            val userId = backStackEntry.arguments?.getString("userId") ?: return@composable
            ProfileScreen(userId = userId)
        }
        composable("home") {
            HomeScreen()
        }
    }
}
```

## Testing

### ViewModel Test

```kotlin
@OptIn(ExperimentalCoroutinesApi::class)
class LoginViewModelTest {

    private val testDispatcher = StandardTestDispatcher()

    @Before
    fun setup() {
        Dispatchers.setMain(testDispatcher)
    }

    @After
    fun tearDown() {
        Dispatchers.resetMain()
    }

    @Test
    fun `login success updates state to Success`() = runTest {
        val viewModel = LoginViewModel(FakeLoginUseCase())
        viewModel.login("test@test.com", "password")
        testDispatcher.scheduler.advanceUntilIdle()
        assertEquals(LoginUiState.Success::class, viewModel.uiState.value::class)
    }
}
```

## Commands

| Command | Usage | Pattern |
|---------|-------|---------|
| `/kotlin:build` | Build project | 1 (bash) |
| `/kotlin:test` | Run tests | 1 (bash) |
| `/kotlin:screen` | Create screen | 3 (full) |
| `/kotlin:viewmodel` | Create ViewModel | 2 (skill) |
| `/kotlin:api` | Add API endpoint | 2 (skill) |
| `/kotlin:nav` | Setup navigation | 2 (skill) |
| `/kotlin:room` | Setup Room DB | 2 (skill) |
| `/kotlin:lint` | Run linter | 1 (bash) |
