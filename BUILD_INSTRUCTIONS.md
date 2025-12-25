# Build Instructions

This project uses code generation for dependency injection and test mocks. After making changes to the presentation layer, you need to run the build_runner to generate the necessary files.

## Prerequisites
- Flutter SDK installed and configured
- All dependencies installed via `flutter pub get`

## Steps to Build

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Generate code (DI configuration and test mocks):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Run tests:**
   ```bash
   flutter test
   ```

## Generated Files

The build_runner will generate:
- `lib/config/di/di.config.dart` - Dependency injection configuration
- `test/**/*.mocks.dart` - Mock classes for unit tests

## Troubleshooting

If you encounter build errors:
1. Clean the project: `flutter clean`
2. Get dependencies: `flutter pub get`
3. Delete old generated files: `flutter pub run build_runner clean`
4. Generate again: `flutter pub run build_runner build --delete-conflicting-outputs`

## Notes

The `ForgetPasswordCubit` has been registered with the `@injectable` annotation and will be automatically registered in the DI container after running build_runner.
