import 'package:flower_app/features/user_addresses/add_update_adrees/data/models/city_model.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/data/models/state_model.dart';

abstract class AddUpdateAddressLocalDataSource {
  Future<List<StateModel>> getGovernorates();
  Future<List<CityModel>> getCities();
}
