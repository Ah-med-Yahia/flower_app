import 'dart:io';
import 'package:flower_app/features/tabs/profile/profile_main/domain/use_cases/get_user_data_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/base_state/base_state.dart';
import '../../data/models/request/edit_user_data_request_model.dart';
import '../../domain/entities/user_data_response_entity.dart';
import '../../domain/use_cases/update_user_profile_use_case.dart';
import '../../domain/use_cases/upload_image_use_case.dart';
import 'edit_profile_events.dart';
import 'edit_profile_states.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileStates> {
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final UploadImageUseCase _uploadImageUseCase;
  final GetUserDataUseCase _getUserDataUseCase;

  EditProfileCubit(
    this._updateUserProfileUseCase,
    this._uploadImageUseCase,
    this._getUserDataUseCase,
  ) : super(const EditProfileStates());

  void doIntent(EditProfileEvents event) async {
    switch (event) {
      case ImagePickerEvent():
        await _uploadImage(event.imageFile);
      case UpdateUserDataEvent():
        await _updateProfile(event.requestModel, event.currentData);
      case NavigateToChangePasswordEvent():
        _navigateToChangePasswordScreen();
    }
  }

  // Future<void> _updateProfile() async {
  //   await _handleDataCalling<UserDataResponseEntity>(
  //     () => _updateUserProfileUseCase.execute(
  //       requestModel: EditUserDataRequestModel(
  //         firstName: state.userDataState.data?.userEntity.firstName,
  //         lastName: state.userDataState.data?.userEntity.lastName,
  //         phoneNumber: state.userDataState.data?.userEntity.phoneNumber,
  //       ),
  //       currentData: state.userDataState.data ?? const UserDataResponseEntity(),
  //     ),
  //     (baseState) => state.copyWith(userDataState: baseState),
  //   );
  // }
  //
  // Future<void> _handleDataCalling<T>(
  //   Future<BaseResponse<T>> Function() useCaseCall,
  //   EditProfileStates Function(BaseState<T> baseState) stateUpdate,
  // ) async {
  //   emit(stateUpdate(BaseState<T>(isLoading: true)));
  //   final res = await useCaseCall();
  //   res.when(
  //     success: (data) =>
  //         emit(stateUpdate(BaseState<T>(isLoading: false, data: data))),
  //     failure: (error) => emit(
  //       stateUpdate(
  //         BaseState<T>(isLoading: false, errorMessage: error.message),
  //       ),
  //     ),
  //   );
  // }
  Future<void> _uploadImage(File imageFile) async {
    emit(
      state.copyWith(
        imageUploadState: const BaseState<String>(isLoading: true),
      ),
    );

    final res = await _uploadImageUseCase.execute(imageFile);
    res.when(
      success: (data) async {
        final res = await _getUserDataUseCase();
        res.when(
          success: (data) => emit(
            state.copyWith(
              imageUploadState: BaseState<String>(
                isLoading: false,
                data: data.user.imgAvatarURL,
                errorMessage: null,
              ),
            ),
          ),
          failure: (e) => emit(
            state.copyWith(
              userDataState: BaseState<UserDataResponseEntity>(
                isLoading: false,
                data: null,
                errorMessage: e.message,
              ),
            ),
          ),
        );
      },
      failure: (e) => emit(
        state.copyWith(
          imageUploadState: BaseState<String>(
            isLoading: false,
            data: null,
            errorMessage: e.message,
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile(
    EditUserDataRequestModel requestModel,
    UserDataResponseEntity currentData,
  ) async {
    emit(
      state.copyWith(
        userDataState: const BaseState<UserDataResponseEntity>(isLoading: true),
      ),
    );
    final res = await _updateUserProfileUseCase.execute(
      requestModel: requestModel,
      currentData: currentData,
    );
    res.when(
      success: (data) {
        emit(
          state.copyWith(
            userDataState: BaseState<UserDataResponseEntity>(
              isLoading: false,
              data: data,
              errorMessage: null,
            ),
            navigateTo: NavigationAction.profileScreen,
          ),
        );
      },
      failure: (e) {
        emit(
          state.copyWith(
            userDataState: BaseState<UserDataResponseEntity>(
              isLoading: false,
              data: null,
              errorMessage: e.message,
            ),
          ),
        );
      },
    );
  }

  void _navigateToChangePasswordScreen() {
    emit(state.copyWith(navigateTo: NavigationAction.changePasswordScreen));
  }
}
