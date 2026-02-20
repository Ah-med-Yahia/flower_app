import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/domain/usecases/delete_saved_address_usecase.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/domain/usecases/get_all_saved_addresses_usecase.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_events.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_states.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_ui_events.dart';
import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavedAddressesCubit extends Cubit<SavedAddressesStates> {
  final GetAllSavedAddressesUsecase _getAllSavedAddressesUsecase;
  final DeleteSavedAddressUsecase _deleteSavedAddressUsecase;

  SavedAddressesCubit(
    this._getAllSavedAddressesUsecase,
    this._deleteSavedAddressUsecase,
  ) : super(SavedAddressesStates());
  void onEvent(SavedAddressesEvent event) {
    switch (event) {
      case GetSavedAddressesEvent():
        _getSavedAddresses();
      case DeleteSavedAddressEvent(:final addressId):
        _deleteSavedAddress(addressId);
      case EditSavedAddressEvent(:final address):
        _navigateToAddUpdateAddressScreen(address);
      case AddNewAddressEvent():
        _navigateToAddUpdateAddressScreen(null);
    }
  }

  void _getSavedAddresses() async {
    emit(
      state.copyWith(
        savedAddressesState: const BaseState(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );
    final response = await _getAllSavedAddressesUsecase.call();

    response.when(
      success: (data) {
        emit(
          state.copyWith(
            savedAddressesState: BaseState(
              isLoading: false,
              data: data,
              errorMessage: null,
            ),
          ),
        );
      },
      failure: (errorHandler) {
        emit(
          state.copyWith(
            savedAddressesState: BaseState(
              isLoading: false,
              data: null,
              errorMessage: errorHandler.message,
            ),
          ),
        );
      },
    );
  }

  void _deleteSavedAddress(String addressId) async {
    emit(
      state.copyWith(
        savedAddressesState: const BaseState(
          isLoading: true,
          errorMessage: null,
        ),
      ),
    );
    _deleteSavedAddressUsecase.call(addressId).then((response) {
      response.when(
        success: (data) {
          emit(
            state.copyWith(
              savedAddressesState: BaseState(
                isLoading: false,
                data: data,
                errorMessage: null,
              ),
            ),
          );
        },
        failure: (errorHandler) {
          emit(
            state.copyWith(
              savedAddressesState: BaseState(
                isLoading: false,
                errorMessage: errorHandler.message,
              ),
            ),
          );
        },
      );
    });
  }

  void _navigateToAddUpdateAddressScreen(AddressEntity? address) {
    emit(
      state.copyWith(
        navigationEvent: NavigateToAddUpdateAddressUiEvent(address),
      ),
    );
  }
}
