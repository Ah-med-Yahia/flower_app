import 'package:equatable/equatable.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../../../../core/constants/app_text_constants.dart';
import '../../domain/entities/user_data_response.dart';

class ProfileMainStates extends Equatable {
  final bool isNotificationsEnabled;
  final BaseState<UserDataResponse> userData;
  final String? selectedLanguage;

  const ProfileMainStates({
    this.isNotificationsEnabled = true,
    this.userData = const BaseState<UserDataResponse>(),
    this.selectedLanguage = AppTextConstants.english,
  });

  ProfileMainStates copyWith({
    bool? isNotificationsEnabled,
    BaseState<UserDataResponse>? userData,
    String? selectedLanguage,
  }) {
    return ProfileMainStates(
      isNotificationsEnabled:
          isNotificationsEnabled ?? this.isNotificationsEnabled,
      userData: userData ?? this.userData,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  @override
  List<Object?> get props => [
    isNotificationsEnabled,
    userData,
    selectedLanguage,
  ];
}
