import 'dart:convert';

import 'package:flower_app/core/constants/app_asset.dart';
import 'package:flower_app/core/constants/assets_keys_constants.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/add_update_adrees/data/data_source/remote/local/add_update_address_local_data_source.dart';
import 'package:flower_app/features/add_update_adrees/data/models/city_model.dart';
import 'package:flower_app/features/add_update_adrees/data/models/state_model.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddUpdateAddressLocalDataSource)
class AddUpdateAddressLocalDataSourceImpl
    implements AddUpdateAddressLocalDataSource {
  @override
  Future<List<StateModel>> getGovernorates() async {
    try {
      final response = await rootBundle.loadString(AppAsset.statesJson);
      final jsonList = json.decode(response) as List;
      final governoratesData = jsonList.firstWhere(
        (element) =>
            element[AssetsKeysConstants.typeKey] ==
                AssetsKeysConstants.tableType &&
            element[AssetsKeysConstants.nameKey] ==
                AssetsKeysConstants.governoratesTableName,
        orElse: () => throw Exception(ErrorsConstant.failedToLoadJsonError),
      );
      if (governoratesData[AssetsKeysConstants.dataKey] == null) {
        throw Exception(ErrorsConstant.governoratesDataIsNullError);
      }
      final governorates =
          (governoratesData[AssetsKeysConstants.dataKey] as List)
              .map((e) => StateModel.fromJson(e))
              .toList();

      return governorates;
    } catch (e) {
      throw Exception(ErrorsConstant.failedToLoadJsonError);
    }
  }

  @override
  Future<List<CityModel>> getCities() async {
    try {
      final response = await rootBundle.loadString(AppAsset.citiesJson);
      final jsonList = json.decode(response) as List;
      final citiesData = jsonList.firstWhere(
        (element) =>
            element[AssetsKeysConstants.typeKey] ==
                AssetsKeysConstants.tableType &&
            element[AssetsKeysConstants.nameKey] ==
                AssetsKeysConstants.citiesTableName,
        orElse: () => throw Exception(ErrorsConstant.failedToLoadJsonError),
      );
      if (citiesData[AssetsKeysConstants.dataKey] == null) {
        throw Exception(ErrorsConstant.citiesDataIsNullError);
      }
      final cities = (citiesData[AssetsKeysConstants.dataKey] as List)
          .map((e) => CityModel.fromJson(e))
          .toList();

      return cities;
    } catch (e) {
      throw Exception(ErrorsConstant.failedToLoadJsonError);
    }
  }
}
