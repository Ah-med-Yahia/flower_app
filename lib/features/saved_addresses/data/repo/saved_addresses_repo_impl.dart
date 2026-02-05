import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/saved_addresses/data/data_sources/remote/saved_addresses_remote_datasource.dart';
import 'package:flower_app/features/saved_addresses/data/mappers/saved_addresses_mapper.dart';
import 'package:flower_app/features/saved_addresses/domain/models/saved_addresses_response_entity.dart';
import 'package:flower_app/features/saved_addresses/domain/repo/saved_addresses_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SavedAddressesRepo)
class SavedAddressesRepoImpl implements SavedAddressesRepo {
  final SavedAddressesRemoteDatasource _remoteDatasource;

  SavedAddressesRepoImpl(this._remoteDatasource);

  @override
  Future<BaseResponse<SavedAddressesResponseEntity>> getSavedAddresses() async {
    final response = await _remoteDatasource.getSavedAddresses();
    return response.when(
      success: (data) {
        return BaseResponse.success(data.toEntity());
      },
      failure: (errorHandler) {
        return BaseResponse.failure(errorHandler);
      },
    );
  }

  @override
  Future<BaseResponse<SavedAddressesResponseEntity>> deleteAddress(
    String id,
  ) async {
    final response = await _remoteDatasource.deleteAddress(id);
    return response.when(
      success: (data) {
        return BaseResponse.success(data.toEntity());
      },
      failure: (errorHandler) {
        return BaseResponse.failure(errorHandler);
      },
    );
  }
}
