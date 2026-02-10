sealed class SplashSideEffect {}

class NavigateToHomeSideEffect extends SplashSideEffect {}

class NavigateToLoginSideEffect extends SplashSideEffect {}

class ErrorSideEffect extends SplashSideEffect {
  final String message;

  ErrorSideEffect(this.message);
}
