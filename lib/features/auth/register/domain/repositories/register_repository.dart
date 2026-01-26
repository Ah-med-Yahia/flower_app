import '../../../../../config/base_response/base_response.dart';
import '../../data/models/register_request/register_request.dart';
import '../entities/register_entity.dart';

abstract class RegisterRepository {
  Future<BaseResponse<RegisterEntity>> register(RegisterRequestModel request);
}
