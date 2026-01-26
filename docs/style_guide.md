# Flutter Team Naming Conventions Guide

## Repository Pattern

### Abstract Repository (Interface)
❌ **Don't:**
- `LoginRepoContract`
- `LoginRepository` (too verbose)
- `ILoginRepository`

✅ **Do:**
- `LoginRepo` (abstract class/interface)

### Repository Implementation
❌ **Don't:**
- `LoginRepoImplementation`
- `LoginRepository`
- `LoginRepoService`

✅ **Do:**
- `LoginRepoImpl`

### Examples:
```dart
// ❌ Wrong
abstract class LoginRepoContract { }
class LoginRepository implements LoginRepoContract { }

// ✅ Correct
abstract class LoginRepo { }
class LoginRepoImpl implements LoginRepo { }
```

---

## Data Sources

### Remote Data Sources
❌ **Don't:**
- `LoginRemoteDS`
- `LoginRemote`
- `LoginAPI`
- `LoginRemoteDataSourceImpl`

✅ **Do:**
- `LoginRemoteDataSource`

### Local Data Sources
❌ **Don't:**
- `LoginLocalDS`
- `LoginLocal`
- `LoginCache`
- `LoginLocalDataSourceImpl`

✅ **Do:**
- `LoginLocalDataSource`

### Examples:
```dart
// ❌ Wrong
class LoginRemoteDS { }
class LoginLocalDS { }

// ✅ Correct
class LoginRemoteDataSource { }
class LoginLocalDataSource { }
```

---

## Domain Layer

### Entities
❌ **Don't:**
- `UserDTO`
- `UserModel`
- `UserData`
- `UserObject`

✅ **Do:**
- `UserEntity` (entity - domain layer)

### Examples:
```dart
// ❌ Wrong
class UserDTO {
  final String id;
  final String name;
}

class UserModel {
  final String id;
  final String name;
}

// ✅ Correct
class UserEntity {
  final String id;
  final String name;
}
```

---

## Data Layer

### Models (Data Transfer Objects)
❌ **Don't:**
- `UserDTO`
- `UserEntity`
- `UserData`
- `User` (conflicts with domain entity)

✅ **Do:**
- `UserModel` (data layer - for API/DB mapping)

### Examples:
```dart
// ❌ Wrong
class UserDTO {
  final String id;
  final String name;
  
  factory UserDTO.fromJson(Map<String, dynamic> json) => ...
}

// ✅ Correct
class UserModel {
  final String id;
  final String name;
  
  factory UserModel.fromJson(Map<String, dynamic> json) => ...
  
  User toEntity() => User(id: id, name: name);
}
```

---

## State Management (BLoC/Cubit Pattern)

### Cubit
❌ **Don't:**
- `LoginController`
- `LoginManager`
- `LoginViewModel`

✅ **Do:**
- `LoginCubit` (for simple state management)

### States
❌ **Don't:**
- `LoginState` (singular - conflicts with single state classes)
- `LoginBlocStates`
- `LoginScreenStates`

✅ **Do:**
- `LoginStates` (plural - sealed class with multiple states)



### UI Events/Intents
❌ **Don't:**
- `LoginEvent`
- `LoginAction`
- `LoginUserIntent`

✅ **Do:**
- `LoginUIEvent` (for UI-triggered actions)
- `LoginIntent` (for user intentions)

### Examples:
```dart
// ❌ Wrong
class LoginBloc extends Cubit<LoginState> { } // Use Cubit for simple cases
sealed class LoginState { }
sealed class LoginEvent { } // Conflicts with LoginUIEvent

// ✅ Correct
class LoginCubit extends Cubit<LoginStates> { }

sealed class LoginStates {
  const LoginStates();
}

class LoginInitial extends LoginStates { }
class LoginLoading extends LoginStates { }
class LoginSuccess extends LoginStates { }
class LoginError extends LoginStates { }

sealed class LoginUIEvent {
  const LoginUIEvent();
}

class LoginButtonPressed extends LoginUIEvent { }
class LogoutRequested extends LoginUIEvent { }
```

---

## Presentation Layer Structure

### Folder Structure
❌ **Don't use "views" folder:**
```
presentation/
  views/
    login_view.dart
    home_view.dart
```

✅ **Do use "screens" and "widgets":**
```
presentation/
  screens/
    login_screen.dart
    home_screen.dart
  widgets/
    custom_button_widget.dart
    user_card_widget.dart
```

### Screen Files
❌ **Don't:**
- `LoginView`
- `LoginPage` (unless using navigation context)
- `LoginUI`

✅ **Do:**
- `LoginScreen`

### Widget Files
❌ **Don't:**
- `LoginFormView`
- `CustomButtonView`

✅ **Do:**
- `LoginFormWidget` (widget)
- `CustomButtonWidget` (widget)

### Examples:
```dart
// ❌ Wrong - In views folder
// views/login_view.dart
class LoginView extends StatelessWidget { }

// ❌ Wrong - In views folder
// views/widgets/login_form_view.dart
class LoginFormView extends StatelessWidget { }

// ✅ Correct - In screens folder
// screens/login_screen.dart
class LoginScreen extends StatelessWidget { }

// ✅ Correct - In widgets folder
// widgets/login_form_widget.dart
class LoginFormWidget extends StatelessWidget { }
```

---

## Complete Example Structure

```
lib/
├── features/
│   └── login/
│       ├── data/
│       │   ├── models/
│       │   │   └── user_model.dart          # UserModel (DTO)
│       │   ├── datasources/
│       │   │   ├── login_remote_datasource.dart
│       │   │   └── login_local_datasource.dart
│       │   └── repositories/
│       │       └── login_repo_impl.dart     # LoginRepoImpl
│       ├── domain/
│       │   ├── entities/
│       │   │   └── user.dart                # User (Entity)
│       │   ├── repositories/
│       │   │   └── login_repo.dart          # LoginRepo (Abstract)
│       │   └── usecases/
│       │       └── login_usecase.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── login_cubit.dart         # LoginCubit
│           │   ├── login_states.dart        # LoginStates
│           │   └── login_ui_event.dart      # LoginUIEvent
│           ├── screens/
│           │   └── login_screen.dart        # LoginScreen
│           └── widgets/
│               ├── login_form.dart
│               └── login_button.dart
```

---