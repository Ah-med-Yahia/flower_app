import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_response_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/city_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/location_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/state_entity.dart';

class AddUpdateAddresseStates {
  final BaseState<List<StateEntity>>? governoratesState;
  final BaseState<List<CityEntity>>? citiesState;
  final BaseState<LocationEntity>? locationState;
  final BaseState<AddUpdateAddressResponseEntity>? addUpdateState;

  AddUpdateAddresseStates({
    this.governoratesState,
    this.citiesState,
    this.locationState,
    this.addUpdateState,
  });

  AddUpdateAddresseStates copyWith({
    BaseState<List<StateEntity>>? governoratesState,
    BaseState<List<CityEntity>>? citiesState,
    BaseState<LocationEntity>? locationState,
    BaseState<AddUpdateAddressResponseEntity>? addUpdateState,
  }) {
    return AddUpdateAddresseStates(
      governoratesState: governoratesState ?? this.governoratesState,
      citiesState: citiesState ?? this.citiesState,
      locationState: locationState ?? this.locationState,
      addUpdateState: addUpdateState ?? this.addUpdateState,
    );
  }
}
