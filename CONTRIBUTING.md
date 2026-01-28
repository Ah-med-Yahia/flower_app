# Contributing to Flower App

Thank you for your interest in contributing to the Flower App! We welcome contributions from the community to help improve this project.

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: This project requires Flutter version `^3.9.2`.
- **Git**: Ensure you have Git installed.

### Setup
1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd flower_app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate code**:
   This project uses code generation (e.g., specific `freezed`, `json_serializable`, `retrofit`). Run the build runner to generate the necessary files:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

## 🛠 Development Workflow

### Branching Strategy
- **Target Branch**: All Pull Requests should come from a feature branch and target the `dev` branch.
- **Naming Convention**: Use descriptive branch names (e.g., `feat/login-screen`, `fix/api-error`).

### Commits & PR Titles
We enforce **Conventional Commits** to keep our history clean and readable. Please refer to the [.github/PULL_REQUEST_TEMPLATE.md](.github/PULL_REQUEST_TEMPLATE.md) for details on the format.

**Format**: `type(scope): Subject`

**Examples**:
- `feat(auth): Add login with Google`
- `fix(ui): Resolve overflow on home screen`

**Allowed Types**:
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code (white-space, formatting, etc)
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `build`: Changes that affect the build system or external dependencies
- `ci`: Changes to our CI configuration files and scripts
- `chore`: Other changes that don't modify src or test files
- `revert`: Reverts a previous commit

> [!IMPORTANT]
> The subject must start with an **uppercase letter**.

## ✅ Code Quality

### Naming Conventions & Style Guide
Please strictly follow the project's naming conventions and coding style as defined in [docs/style_guide.md](docs/style_guide.md). This guide covers:
- Repository patterns
- Component naming (Screens, Widgets, Cubits)
- Architecture layer structure

### Linting
We use `flutter_lints` to enforce strict constraints. Ensure your code is analyzed before pushing:
```bash
flutter analyze
```

### Testing
Run unit and widget tests to ensure your changes don't break existing functionality:
```bash
flutter test
```

## 📝 Pull Request Process
1. Ensure your code builds and passes all tests.
2. Update the `CONTRIBUTING.md` or `README.md` if you are changing documentation.
3. Open a PR targeting the `dev` branch.
4. Fill out the **Pull Request Template** provided in the description.
5. Wait for code review!

Happy Coding! 🌸
