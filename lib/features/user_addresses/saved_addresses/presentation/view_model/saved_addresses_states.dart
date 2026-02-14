import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_ui_events.dart';

class SavedAddressesStates {
  BaseState<SavedAddressesResponseEntity>? savedAddressesState;

  SavedAddressesUiEvents? navigationEvent;

  SavedAddressesStates({this.savedAddressesState, this.navigationEvent});

  SavedAddressesStates copyWith({
    BaseState<SavedAddressesResponseEntity>? savedAddressesState,
    SavedAddressesUiEvents? navigationEvent,
  }) {
    return SavedAddressesStates(
      savedAddressesState: savedAddressesState ?? this.savedAddressesState,
      navigationEvent: navigationEvent,
    );
  }
}
