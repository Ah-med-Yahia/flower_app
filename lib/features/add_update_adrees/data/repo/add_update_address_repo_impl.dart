import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/add_update_adrees/data/data_source/remote/add_update_address_remote_data_source.dart';
import 'package:flower_app/features/add_update_adrees/data/mappers/add_update_address_mapper.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_response_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/repo/add_update_address_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddUpdateAddressRepo)
class AddUpdateAddressRepoImpl implements AddUpdateAddressRepo {
  final AddUpdateAddressRemoteDataSource _remoteDataSource;

  AddUpdateAddressRepoImpl(this._remoteDataSource);

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
}
