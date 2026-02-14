import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/add_address_usecase.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/get_cities_by_state_use_case.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/get_coordinates_from_address_usecase.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/get_current_location_usecase.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/get_states_uescase.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/update_address_usecase.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view_model/add_update_addresse_events.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view_model/add_update_addresse_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddUpdateAddresseCubit extends Cubit<AddUpdateAddresseStates> {
  final GetCurrentLocationUsecase _getCurrentLocationUseCase;
  final AddAddressUsecase _addAddressUsecase;
  final UpdateAddressUsecase _updateAddressUsecase;
  final GetStatesUescase _getStatesUescase;
  final GetCitiesByStateUseCase _getCitiesByStateUseCase;
  final GetCoordinatesFromAddressUseCase _getCoordinatesFromAddressUseCase;

  AddUpdateAddresseCubit(
    this._getCurrentLocationUseCase,
    this._addAddressUsecase,
    this._updateAddressUsecase,
    this._getStatesUescase,
    this._getCitiesByStateUseCase,
    this._getCoordinatesFromAddressUseCase,
  ) : super(AddUpdateAddresseStates());

  void onEvent(AddUpdateAddresseEvents event) {
    switch (event) {
      case LoadInitialDataEvent():
        loadInitialData(skipCurrentLocation: event.skipCurrentLocation);
        break;
      case GetCurrentLocationEvent():
        getCurrentLocation();
        break;
      case AddAddressEvent():
        addAddress(event.address);
        break;
      case UpdateAddressEvent():
        updateAddress(event.address, event.id);
        break;
      case GetGovernoratesEvent():
        getGovernorates();
        break;
      case GetCitiesEvent():
        getCities(event.governorateId);
        break;
      case OnCityChangedEvent():
        onCityChanged(event.cityName, event.stateName);
        break;
    }
  }

  Future<void> loadInitialData({bool skipCurrentLocation = false}) async {
    if (!skipCurrentLocation) {
      getCurrentLocation();
    }
    getGovernorates();
  }

  Future<void> getCurrentLocation() async {
    emit(
      state.copyWith(
        locationState: const BaseState(
          data: null,
          errorMessage: null,
          isLoading: true,
        ),
      ),
    );

    final result = await _getCurrentLocationUseCase.call();

    result.when(
      success: (location) {
        emit(
          state.copyWith(
            locationState: BaseState(
              data: location,
              errorMessage: null,
              isLoading: false,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            locationState: BaseState(
              data: null,
              errorMessage: error.message,
              isLoading: false,
            ),
          ),
        );
      },
    );
  }

  // Placeholder methods
  Future<void> addAddress(
    AddUpdateAddressRequestEntity addUpdateAddressRequestEntity,
  ) async {
    emit(
      state.copyWith(
        addUpdateState: const BaseState(
          data: null,
          errorMessage: null,
          isLoading: true,
        ),
      ),
    );

    final result = await _addAddressUsecase.call(addUpdateAddressRequestEntity);

    result.when(
      success: (addresses) {
        emit(
          state.copyWith(
            addUpdateState: BaseState(
              data: addresses,
              errorMessage: null,
              isLoading: false,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            addUpdateState: BaseState(
              data: null,
              errorMessage: error.message,
              isLoading: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> updateAddress(
    AddUpdateAddressRequestEntity addUpdateAddressRequestEntity,
    String id,
  ) async {
    emit(
      state.copyWith(
        addUpdateState: const BaseState(
          data: null,
          errorMessage: null,
          isLoading: true,
        ),
      ),
    );

    final result = await _updateAddressUsecase.call(
      addUpdateAddressRequestEntity,
      id,
    );

    result.when(
      success: (addresses) {
        emit(
          state.copyWith(
            addUpdateState: BaseState(
              data: addresses,
              errorMessage: null,
              isLoading: false,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            addUpdateState: BaseState(
              data: null,
              errorMessage: error.message,
              isLoading: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> getGovernorates() async {
    emit(
      state.copyWith(
        governoratesState: const BaseState(
          data: null,
          errorMessage: null,
          isLoading: true,
        ),
      ),
    );

    final result = await _getStatesUescase.call();

    result.when(
      success: (governorates) {
        emit(
          state.copyWith(
            governoratesState: BaseState(
              data: governorates,
              errorMessage: null,
              isLoading: false,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            governoratesState: BaseState(
              data: null,
              errorMessage: error.message,
              isLoading: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> getCities(String governorateId) async {
    emit(
      state.copyWith(
        citiesState: const BaseState(
          data: null,
          errorMessage: null,
          isLoading: true,
        ),
      ),
    );

    final result = await _getCitiesByStateUseCase.call(governorateId);

    result.when(
      success: (cities) {
        emit(
          state.copyWith(
            citiesState: BaseState(
              data: cities,
              errorMessage: null,
              isLoading: false,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            citiesState: BaseState(
              data: null,
              errorMessage: error.message,
              isLoading: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> onCityChanged(String stateName, String cityName) async {
    emit(
      state.copyWith(
        locationState: const BaseState(
          data: null,
          errorMessage: null,
          isLoading: true,
        ),
      ),
    );

    final result = await _getCoordinatesFromAddressUseCase.call(
      cityName: cityName,
      stateName: stateName,
    );

    result.when(
      success: (location) {
        emit(
          state.copyWith(
            locationState: BaseState(
              data: location,
              errorMessage: null,
              isLoading: false,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            locationState: BaseState(
              data: null,
              errorMessage: error.message,
              isLoading: false,
            ),
          ),
        );
      },
    );
  }
}
