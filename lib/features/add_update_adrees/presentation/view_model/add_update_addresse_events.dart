import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_request_entity.dart';

sealed class AddUpdateAddresseEvents {}

class LoadInitialDataEvent extends AddUpdateAddresseEvents {}

class GetCurrentLocationEvent extends AddUpdateAddresseEvents {}

class AddAddressEvent extends AddUpdateAddresseEvents {
  final AddUpdateAddressRequestEntity address;

  AddAddressEvent({required this.address});
}

class UpdateAddressEvent extends AddUpdateAddresseEvents {
  final AddUpdateAddressRequestEntity address;
  final String id;

  UpdateAddressEvent({required this.address, required this.id});
}

class GetGovernoratesEvent extends AddUpdateAddresseEvents {}

class GetCitiesEvent extends AddUpdateAddresseEvents {
  final String governorateId;

  GetCitiesEvent({required this.governorateId});
}

class OnCityChangedEvent extends AddUpdateAddresseEvents {
  final String stateName;
  final String cityName;
  OnCityChangedEvent({required this.stateName, required this.cityName});
}
