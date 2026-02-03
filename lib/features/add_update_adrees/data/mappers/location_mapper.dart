// state model to entity
import 'package:flower_app/features/add_update_adrees/data/models/city_model.dart';
import 'package:flower_app/features/add_update_adrees/data/models/state_model.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/city_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/state_entity.dart';

extension StateModelToEntityMapper on StateModel {
  StateEntity toEntity() {
    return StateEntity(
      id: id,
      governorateNameAr: governorateNameAr,
      governorateNameEn: governorateNameEn,
    );
  }
}

// city model to entity
extension CityModelToEntityMapper on CityModel {
  CityEntity toEntity() {
    return CityEntity(
      id: id,
      governorateId: governorateId,
      cityNameAr: cityNameAr,
      cityNameEn: cityNameEn,
    );
  }
}
