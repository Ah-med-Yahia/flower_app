import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/constants/errors_constants.dart';
import '../../domain/use_cases/get_user_data_use_case.dart';
import '../../domain/use_cases/load_cached_user_data_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import '../../domain/use_cases/verify_session_use_case.dart';
import 'profile_main_intents.dart';
import 'profile_main_side_effects.dart';
import 'profile_main_states.dart';

@injectable
class ProfileMainCubit extends Cubit<ProfileMainStates> {
  ProfileMainCubit(
    this._getUserDataUseCase,
    this._verifySessionUseCase,
    this._loadCachedUserDataUseCase,
    this._logoutUseCase,
  ) : super(const ProfileMainStates());

  final GetUserDataUseCase _getUserDataUseCase;
  final LoadCachedUserDataUseCase _loadCachedUserDataUseCase;
  final VerifySessionUseCase _verifySessionUseCase;
  final LogoutUseCase _logoutUseCase;
  final _sideEffectController =
      StreamController<ProfileMainSideEffects>.broadcast();

  Stream<ProfileMainSideEffects> get sideEffects =>
      _sideEffectController.stream;

  Future<void> doIntent(ProfileMainIntents intent) async {
    switch (intent) {
      case GetUserDataIntent():
        await _checkTokenAndLoadData();
      case NotificationToggledIntent():
        _notifyUIToggled();
      case SelectLanguageIntent():
        _handleLanguageSelection();
      case EditProfileIntent():
        _navigateToEditProfile();
      case LoadCachedDataIntent():
        await _loadCachedUserData();
      case LogoutIntent():
        await _logout();
      case UpdateLanguageIntent():
        _updateLanguage(intent.language);
    }
  }

  void _emitSideEffect(ProfileMainSideEffects effect) {
    if (_sideEffectController.isClosed) return;
    try {
      _sideEffectController.add(effect);
    } on StateError {
      // Ignore - controller was already closed
    }
  }

  void _updateLanguage(String language) {
    emit(state.copyWith(selectedLanguage: language));
  }

  Future<void> _checkTokenAndLoadData() async {
    emit(state.copyWith(userData: state.userData.copyWith(isLoading: true)));

    final sessionResult = await _verifySessionUseCase.call();
    await sessionResult.when(
      success: (status) async {
        switch (status) {
          case SessionValid():
            await _fetchUserData();
          case SessionInvalid(:final reason):
            emit(
              state.copyWith(
                userData: state.userData.copyWith(
                  isLoading: false,
                  errorMessage: reason,
                ),
              ),
            );
            _emitSideEffect(NavigateToLoginSideEffect());
        }
      },
      failure: (error) {
        // TODO(Salah): Handle Localization
        emit(
          state.copyWith(
            userData: state.userData.copyWith(
              isLoading: false,
              errorMessage:
                  '${ErrorsConstant.authenticationCheckError} ${error.message}',
            ),
          ),
        );
        // TODO(Salah): Handle Localization
        _emitSideEffect(
          ShowErrorSideEffect(
            '${ErrorsConstant.authenticationCheckError} ${error.message}',
          ),
        );
      },
    );
  }

  Future<void> _fetchUserData() async {
    final apiCallResult = await _getUserDataUseCase.call();
    apiCallResult.when(
      success: (userData) {
        emit(
          state.copyWith(
            userData: state.userData.copyWith(
              data: userData,
              isLoading: false,
              errorMessage: null,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            userData: state.userData.copyWith(
              isLoading: false,
              errorMessage: error.message,
            ),
          ),
        );
      },
    );
  }

  void _notifyUIToggled() {
    emit(state.copyWith(isNotificationsEnabled: !state.isNotificationsEnabled));
  }

  void _handleLanguageSelection() {
    _emitSideEffect(ShowLanguageBottomSheetSideEffect());
  }

  void _navigateToEditProfile() {
    _emitSideEffect(NavigateToEditProfileSideEffect());
  }

  /// Get cached user data without API call
  Future<void> _loadCachedUserData() async {
    emit(state.copyWith(userData: state.userData.copyWith(isLoading: true)));
    final loadUserDataResult = await _loadCachedUserDataUseCase.call();
    loadUserDataResult.when(
      success: (userData) {
        if (userData != null) {
          emit(
            state.copyWith(
              userData: state.userData.copyWith(
                isLoading: false,
                //data: userData,
              ),
            ),
          );
        } else {
          emit(
            state.copyWith(userData: state.userData.copyWith(isLoading: false)),
          );
          // TODO(Salah): Handle Localization
          _emitSideEffect(
            ShowErrorSideEffect(ErrorsConstant.noCacheDataAvailableError),
          );
        }
      },
      failure: (error) {
        emit(
          state.copyWith(userData: state.userData.copyWith(isLoading: false)),
        );
        // TODO(Salah): Handle Localization
        _emitSideEffect(
          ShowErrorSideEffect(
            '${ErrorsConstant.failedToLoadCachedDataError} ${error.message}',
          ),
        );
        // TODO(ahmed): Remove this log statement in production
        if (kDebugMode) {
          log(
            '${ErrorsConstant.failedToLoadCachedDataError} ${error.message}',
            error: error,
          );
        }
      },
    );
  }

  //TODO(Mahmoud-Younes): Handle logout
  Future<void> _logout() async {
    emit(state.copyWith(userData: state.userData.copyWith(isLoading: true)));
    final logoutResult = await _logoutUseCase.call();
    logoutResult.when(
      success: (_) {
        emit(
          state.copyWith(userData: state.userData.copyWith(isLoading: false)),
        );
        _emitSideEffect(NavigateToLoginSideEffect());
      },
      failure: (error) {
        emit(
          state.copyWith(userData: state.userData.copyWith(isLoading: false)),
        );
        // TODO(Salah): Handle Localization
        _emitSideEffect(
          ShowErrorSideEffect(
            '${ErrorsConstant.logoutFailedError} ${error.message}',
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}
