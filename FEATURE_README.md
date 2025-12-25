# Forget Password Feature - Presentation Layer

## Quick Start

This presentation layer provides a complete UI implementation for the forget password feature.

### Prerequisites
- Domain layer (entities, repositories, use cases) ✅ Already implemented
- Data layer (models, data sources, repository impl) ✅ Already implemented
- Presentation layer (cubit, state, views, widgets) ✅ **This PR**

### Installation

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Generate code:**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Run tests:**
   ```bash
   flutter test test/features/auth/forget_password/presentation/
   ```

## Usage

### Navigation

Add to your router configuration:

```dart
// In app_router.dart
GoRoute(
  path: '/forget-password',
  builder: (context, state) => const ForgetPasswordView(),
)
```

### Direct Usage

```dart
import 'package:online_exam_app/features/auth/forget_password/presentation/views/forget_password_view.dart';

// Navigate to forget password screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ForgetPasswordView()),
);
```

## UI Structure

### ForgetPasswordView
```
┌─────────────────────────────────────┐
│  ← [Back Button]                     │
├─────────────────────────────────────┤
│                                      │
│     Forgot Password                  │
│     Please enter your email address  │
│     to receive a verification code   │
│                                      │
│  ┌───────────────────────────────┐  │
│  │ 📧 Email                       │  │
│  │ Enter your email               │  │
│  └───────────────────────────────┘  │
│                                      │
│  ┌───────────────────────────────┐  │
│  │      Send Code                 │  │
│  └───────────────────────────────┘  │
│                                      │
└─────────────────────────────────────┘
```

## Components

### 1. ForgetPasswordView
- Entry point widget
- Sets up BlocProvider with ForgetPasswordCubit
- Injects dependencies via GetIt

### 2. ForgetPasswordBody
- Main UI implementation
- Contains form with validation
- Displays loading/success/error states
- Shows SnackBar notifications

### 3. CustomEditTextWidget
Reusable text input with features:
- Label and hint text
- Validation support
- Prefix/suffix icons
- Keyboard type configuration
- Enabled/disabled state
- Theme integration

Example:
```dart
CustomEditTextWidget(
  controller: emailController,
  labelText: 'Email',
  hintText: 'Enter your email',
  keyboardType: TextInputType.emailAddress,
  prefixIcon: const Icon(Icons.email_outlined),
  validator: AppValidators.validateEmail,
)
```

### 4. CustomHeaderTitleWidget
Reusable header with:
- Title text
- Optional subtitle
- Configurable alignment
- Theme colors

Example:
```dart
CustomHeaderTitleWidget(
  title: 'Forgot Password',
  subtitle: 'Please enter your email address',
  titleAlign: TextAlign.left,
  subtitleAlign: TextAlign.left,
)
```

## State Management

### ForgetPasswordState
```dart
class ForgetPasswordState {
  final BaseState<ForgetPasswordEntity> forgetPasswordState;
  
  // States:
  // - isLoading: bool
  // - data: ForgetPasswordEntity?
  // - errorMessage: String?
}
```

### ForgetPasswordCubit
```dart
class ForgetPasswordCubit {
  // Methods:
  forgetPassword(String email) // Triggers API call
  
  // State flow:
  // 1. Emit loading state
  // 2. Call ForgetPasswordUseCase
  // 3. Emit success/error state
}
```

## Validation

Email validation checks:
- ✅ Not empty
- ✅ Valid email format (regex)
- ✅ Real-time validation on submit

## UI States

### Loading State
- Button shows CircularProgressIndicator
- Button disabled
- No user interaction allowed

### Success State
- Green SnackBar with success message
- Message from API response
- Auto-dismiss after few seconds

### Error State
- Red SnackBar with error message
- Error from ErrorHandler
- Auto-dismiss after few seconds

## Testing

### Unit Tests
Located in: `test/features/auth/forget_password/presentation/manager/`

Tests cover:
- ✅ Initial state
- ✅ Loading state emission
- ✅ Success state emission
- ✅ Error state emission
- ✅ Use case invocation

Run tests:
```bash
flutter test test/features/auth/forget_password/presentation/manager/forget_password_cubit_test.dart
```

## Dependencies

### Added
- `equatable: ^2.0.5` - State equality

### Used
- `flutter_bloc: ^9.1.1` - State management
- `get_it: ^8.2.0` - Dependency injection
- `injectable: ^2.5.2` - DI annotations

## Theme Colors

The UI uses the following app colors:
- Primary: `#D21E6A` (Pink) - Buttons, focus
- Background: `#F9F9F9` (Light) - Screen background
- Text Primary: `#0C1015` (Dark) - Titles
- Text Secondary: `#535353` (Grey) - Subtitles
- Success: `#0CB359` (Green) - Success messages
- Error: `#CC1010` (Red) - Error messages
- Light Grey: `#CFCFCF` - Borders, disabled

## Error Handling

Errors are handled at multiple levels:

1. **Validation Errors**: Form field validators
2. **Network Errors**: ErrorHandler with proper messages
3. **Unknown Errors**: Fallback to default error message

All errors are displayed via SnackBar with appropriate styling.

## Best Practices

✅ Clean Architecture separation
✅ Reusable widget components
✅ Proper state management
✅ Comprehensive error handling
✅ Form validation
✅ Loading indicators
✅ User feedback (SnackBars)
✅ Null safety
✅ Unit tested
✅ Type-safe
✅ DI with GetIt/Injectable
✅ Immutable state

## Troubleshooting

### Issue: Cubit not found
**Solution**: Run build_runner to generate DI config
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: Test mocks not found
**Solution**: Generate mocks with build_runner
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: Validation not working
**Solution**: Ensure AppValidators is properly imported and form key is used

## Future Enhancements

Potential improvements:
- [ ] Add remember email functionality
- [ ] Add email suggestions
- [ ] Add success navigation to OTP screen
- [ ] Add analytics tracking
- [ ] Add accessibility labels
- [ ] Add localization support

## Related Features

This presentation layer integrates with:
- **Domain Layer**: ForgetPasswordUseCase, ForgetPasswordEntity
- **Data Layer**: ForgetPasswordRepo, RemoteDataSource
- **Core**: BaseState, ErrorHandler, AppValidators

## Contributing

When making changes:
1. Follow existing patterns
2. Add/update tests
3. Run linter: `flutter analyze`
4. Format code: `flutter format .`
5. Test thoroughly

## Support

For issues or questions:
- Check IMPLEMENTATION_SUMMARY.md
- Check BUILD_INSTRUCTIONS.md
- Review existing tests for examples
