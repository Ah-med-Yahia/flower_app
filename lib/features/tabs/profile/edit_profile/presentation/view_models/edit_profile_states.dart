import 'package:equatable/equatable.dart';
import '../../../../../../config/base_state/base_state.dart';
import '../../../../../../core/constants/errors_constants.dart';
import '../../domain/entities/user_data_response_entity.dart';
import 'edit_profile_events.dart';

class EditProfileStates extends Equatable {
  final BaseState<UserDataResponseEntity> userDataState;
  final BaseState<String> imageUploadState;
  final NavigationAction navigateTo;

  const EditProfileStates({
    this.userDataState = const BaseState<UserDataResponseEntity>(),
    this.imageUploadState = const BaseState<String>(),
    this.navigateTo = NavigationAction.none,
  });

  EditProfileStates copyWith({
    BaseState<UserDataResponseEntity>? userDataState,
    BaseState<String>? imageUploadState,
    NavigationAction? navigateTo,
  }) {
    return EditProfileStates(
      userDataState: userDataState ?? this.userDataState,
      imageUploadState: imageUploadState ?? this.imageUploadState,
      navigateTo: navigateTo ?? this.navigateTo,
    );
  }

  bool get isUserDataLoading => userDataState.isLoading;

  bool get isImageUploadLoading => imageUploadState.isLoading;

  UserEntity get userData =>
      userDataState.data?.userEntity ?? const UserEntity();

  String get imageUploadMessage =>
      imageUploadState.data ?? ErrorsConstant.defaultError;

  String get userDataErrorMessage =>
      userDataState.errorMessage ?? ErrorsConstant.defaultError;

  String get imageUploadErrorMessage =>
      imageUploadState.errorMessage ?? ErrorsConstant.defaultError;

  @override
  List<Object?> get props => [userDataState, imageUploadState, navigateTo];
}
