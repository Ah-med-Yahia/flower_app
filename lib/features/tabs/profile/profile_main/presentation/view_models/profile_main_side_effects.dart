// Side Effects = UI Events = Events
sealed class ProfileMainSideEffects {}

class ShowErrorSideEffect extends ProfileMainSideEffects {
  final String message;

  ShowErrorSideEffect(this.message);
}

class ShowLanguageBottomSheetSideEffect extends ProfileMainSideEffects {}

class ShowAlertDialogSideEffect extends ProfileMainSideEffects {}

class LogoutUserSideEffect extends ProfileMainSideEffects {}

//-------------------- NAVIGATION EVENTS --------------------//

class NavigateToLoginSideEffect extends ProfileMainSideEffects {}

class NavigateToEditProfileSideEffect extends ProfileMainSideEffects {}

class NavigateToAppPolicySideEffect extends ProfileMainSideEffects {}

class NavigateToAppInformationSideEffect extends ProfileMainSideEffects {}
