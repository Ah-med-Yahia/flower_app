sealed class ChangePaswordUiIntents {
  const ChangePaswordUiIntents();
}

class ShowLoadingIntent extends ChangePaswordUiIntents {}

class ShowErrorIntent extends ChangePaswordUiIntents {
  final String message;

  const ShowErrorIntent({required this.message});
}

class NavigateToEditProfileIntent extends ChangePaswordUiIntents {
  final String message;

  const NavigateToEditProfileIntent({required this.message});
}
