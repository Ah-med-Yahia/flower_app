import 'package:flower_app/features/auth/register/data/mapper/to_entity_mapper.dart';
import 'package:flower_app/features/auth/register/domain/entities/register_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_data_source.dart';
import '../models/register_request/register_request.dart';

@Injectable(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterDataSource registerDataSource;

  RegisterRepositoryImpl(this.registerDataSource);
  @override
  Future<BaseResponse<RegisterEntity>> register(
    RegisterRequestModel request,
  ) async {
    final response = await registerDataSource.register(request);
    return response.map(
      success: (response) {
        final data = response.data;
        return BaseResponse<RegisterEntity>.success(data.toEntity());
      },
      failure: (failure) {
        return BaseResponse<RegisterEntity>.failure(failure.errorHandler);

      },
    );
  }
}
