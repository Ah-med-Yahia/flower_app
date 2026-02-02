sealed class ProfileMainIntents {}

class GetUserDataIntent extends ProfileMainIntents {}

class LoadCachedDataIntent extends ProfileMainIntents {}

class NotificationToggledIntent extends ProfileMainIntents {}

class SelectLanguageIntent extends ProfileMainIntents {}

class UpdateLanguageIntent extends ProfileMainIntents {
  final String language;

  UpdateLanguageIntent(this.language);
}

class EditProfileIntent extends ProfileMainIntents {}

class LogoutIntent extends ProfileMainIntents {}

class TapAboutUsIntent extends ProfileMainIntents {}

class TapTermsAndConditionsIntent extends ProfileMainIntents {}
