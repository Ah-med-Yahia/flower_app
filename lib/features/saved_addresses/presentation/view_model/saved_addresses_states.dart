import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/saved_addresses/domain/models/saved_addresses_response_entity.dart';
import 'package:flower_app/features/saved_addresses/presentation/view_model/saved_addresses_ui_events.dart';

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
