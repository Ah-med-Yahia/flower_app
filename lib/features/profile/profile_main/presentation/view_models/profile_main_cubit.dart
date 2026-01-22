import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/services/token_service.dart';
import '../../domain/use_cases/get_user_data_use_case.dart';
import 'profile_main_intents.dart';
import 'profile_main_side_effects.dart';
import 'profile_main_states.dart';

@injectable
class ProfileMainCubit extends Cubit<ProfileMainStates> {
  ProfileMainCubit(this._getUserDataUseCase, this._tokenService)
    : super(const ProfileMainStates());

  final GetUserDataUseCase _getUserDataUseCase;
  final TokenService _tokenService;
  final _sideEffectController =
      StreamController<ProfileMainSideEffects>.broadcast();

  Stream<ProfileMainSideEffects> get sideEffects =>
      _sideEffectController.stream;

  Future<void> doIntent(ProfileMainIntents intent) async {
    switch (intent) {
      case GetUserDataIntent():
        await _checkTokenAndLoadData();
      case NotificationIToggledIntent():
        _notifyUIToggled();
      case SelectLanguageIntent():
        _handleLanguageSelection();
      case EditProfileIntent():
        _navigateToEditProfile();
      case LoadCachedDataIntent():
        _loadCachedUserData();
      case LogoutIntent():
        _logout();
    }
  }

  void _emitSideEffect(ProfileMainSideEffects effect) {
    _sideEffectController.add(effect);
  }

  Future<void> _checkTokenAndLoadData() async {
    emit(state.copyWith(userData: state.userData.copyWith(isLoading: true)));
    final isLoggedInResponse = await _tokenService.isLoggedIn();

    await isLoggedInResponse.when(
      success: (isLoggedIn) async {
        if (!isLoggedIn) {
          emit(
            state.copyWith(
              userData: state.userData.copyWith(
                isLoading: false,
                errorMessage: 'User not logged in',
              ),
            ),
          );
          _emitSideEffect(NavigateToLoginSideEffect());
          return;
        }

        final tokenValidResponse = await _tokenService.isTokenValid();
        await tokenValidResponse.when(
          success: (isTokenValid) async {
            if (!isTokenValid) {
              emit(
                state.copyWith(
                  userData: state.userData.copyWith(
                    isLoading: false,
                    errorMessage: 'Session expired',
                  ),
                ),
              );
              return;
            }

            await _apiCall();
          },
          failure: (error) {
            emit(
              state.copyWith(
                userData: state.userData.copyWith(
                  isLoading: false,
                  errorMessage: 'Token validation failed: ${error.message}',
                ),
              ),
            );
            _emitSideEffect(
              ShowErrorSideEffect('Token validation failed: ${error.message}'),
            );
          },
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            userData: state.userData.copyWith(
              errorMessage: 'Authentication check failed: ${error.message}',
            ),
          ),
        );
        _emitSideEffect(
          ShowErrorSideEffect('Authentication check failed: ${error.message}'),
        );
      },
    );
  }

  Future<void> _apiCall() async {
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
        _handleApiErrorTokenExpired(
          errorMessage: error.message,
          statusCode: error.code,
        );
      },
    );
  }

  void _handleApiErrorTokenExpired({
    required String errorMessage,
    required int? statusCode,
  }) {
    if (statusCode == 401) {
      _emitSideEffect(NavigateToLoginSideEffect());
      return;
    }
    _emitSideEffect(ShowErrorSideEffect(errorMessage));
  }

  void _notifyUIToggled() {
    emit(state.copyWith(isNotificationsEnabled: !state.isNotificationsEnabled));
  }

  void _handleLanguageSelection() {
    // Emit side effect to trigger language selection bottom sheet
    _emitSideEffect(ShowLanguageBottomSheetSideEffect());
  }

  void _navigateToEditProfile() {
    _emitSideEffect(NavigateToEditProfileSideEffect());
  }

  /// Get cached user data without API call
  Future<void> _loadCachedUserData() async {
    emit(state.copyWith(userData: state.userData.copyWith(isLoading: true)));
    final userDataResponse = await _tokenService.getUserData();
    userDataResponse.when(
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
          _emitSideEffect(ShowErrorSideEffect('No cached data available'));
        }
      },
      failure: (error) {
        emit(
          state.copyWith(userData: state.userData.copyWith(isLoading: false)),
        );
        _emitSideEffect(
          ShowErrorSideEffect('Failed to load cached data: ${error.message}'),
        );
        if (kDebugMode) {
          log(
            'Failed to load cached user data: ${error.message}',
            error: error,
          );
        }
      },
    );
  }

  Future<void> _logout() async {
    emit(state.copyWith(userData: state.userData.copyWith(isLoading: true)));
    final clearAuthResponse = await _tokenService.clearAuthData();
    clearAuthResponse.when(
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
        _emitSideEffect(ShowErrorSideEffect('Logout failed: ${error.message}'));
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}
