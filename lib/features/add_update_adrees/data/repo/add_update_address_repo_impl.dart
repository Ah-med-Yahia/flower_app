import 'dart:developer';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/config/services/location_service.dart';
import 'package:flower_app/core/constants/assets_keys_constants.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/add_update_adrees/data/data_source/remote/add_update_address_remote_data_source.dart';
import 'package:flower_app/features/add_update_adrees/data/data_source/remote/local/add_update_address_local_data_source.dart';
import 'package:flower_app/features/add_update_adrees/data/mappers/add_update_address_mapper.dart';
import 'package:flower_app/features/add_update_adrees/data/mappers/location_mapper.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_response_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/city_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/location_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/state_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/repo/add_update_address_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddUpdateAddressRepo)
class AddUpdateAddressRepoImpl implements AddUpdateAddressRepo {
  final LocationService _locationService;
  final AddUpdateAddressRemoteDataSource _remoteDataSource;
  final AddUpdateAddressLocalDataSource _localDataSource;

  AddUpdateAddressRepoImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._locationService,
  );

  @override
  Future<BaseResponse<LocationEntity>> getCurrentLocation() async {
    try {
      final position = await _locationService.getCurrentLocation();
      if (position == null) {
        return BaseResponse.failure(
          ErrorHandler.handle(
            Exception(ErrorsConstant.failedToGetCurrentLocation),
          ),
        );
      }
      String? street;
      String? city;
      String? state;
      try {
        final List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          street = place.street;
          city = place.locality ?? place.subAdministrativeArea;
          state = place.administrativeArea;
        }
      } catch (geocodingError) {
        log('Geocoding error: $geocodingError');
      }

      final locationEntity = LocationEntity(
        latitude: position.latitude,
        longitude: position.longitude,
        street: street,
        city: city,
        state: state,
      );

      return BaseResponse.success(locationEntity);
    } catch (error) {
      return BaseResponse.failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<BaseResponse<AddUpdateAddressResponseEntity>> addAddress(
    AddUpdateAddressRequestEntity body,
  ) async {
    final bodyModel = body.toModel();
    final response = await _remoteDataSource.addAddress(bodyModel);
    return response.when(
      success: (model) => BaseResponse.success(model.toEntity()),
      failure: (failure) => BaseResponse.failure(failure),
    );
  }

  @override
  Future<BaseResponse<AddUpdateAddressResponseEntity>> updateAddress(
    AddUpdateAddressRequestEntity body,
    String id,
  ) async {
    final bodyModel = body.toModel();
    final response = await _remoteDataSource.updateAddress(bodyModel, id);
    return response.when(
      success: (model) => BaseResponse.success(model.toEntity()),
      failure: (failure) => BaseResponse.failure(failure),
    );
  }

  @override
  Future<BaseResponse<List<StateEntity>>> getGovernorates() async {
    try {
      final governorates = await _localDataSource.getGovernorates();
      return BaseResponse.success(
        governorates.map((model) => model.toEntity()).toList(),
      );
    } catch (error) {
      return BaseResponse.failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<BaseResponse<List<CityEntity>>> getCities() async {
    try {
      final cities = await _localDataSource.getCities();
      return BaseResponse.success(
        cities.map((model) => model.toEntity()).toList(),
      );
    } catch (error) {
      return BaseResponse.failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<BaseResponse<LocationEntity>> getCoordinatesFromAddress({
    required String cityName,
    required String stateName,
  }) async {
    try {
      String query = '';
      if (cityName.isNotEmpty && stateName.isNotEmpty) {
        query = '$cityName, $stateName, ${AssetsKeysConstants.egypt}';
      } else if (stateName.isNotEmpty) {
        query = '$stateName, ${AssetsKeysConstants.egypt}';
      } else {
        return BaseResponse.failure(
          ErrorHandler.handle(
            Exception(ErrorsConstant.cityNameOrStateNameIsRequired),
          ),
        );
      }

      log('Forward geocoding query: $query');

      final List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        final location = locations.first;

        final locationEntity = LocationEntity(
          latitude: location.latitude,
          longitude: location.longitude,
          city: cityName,
          state: stateName,
        );

        log('Found coordinates: ${location.latitude}, ${location.longitude}');

        return BaseResponse.success(locationEntity);
      } else {
        return BaseResponse.failure(
          ErrorHandler.handle(
            Exception(ErrorsConstant.locationNotFoundForGivenAddress),
          ),
        );
      }
    } catch (error) {
      log('Forward geocoding error: $error');
      return BaseResponse.failure(ErrorHandler.handle(error));
    }
  }
}
