import 'package:flower_app/features/auth/register/domain/entities/register_entity.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../data/models/register_request/register_request.dart';

abstract class RegisterRepository {
  Future<BaseResponse<RegisterEntity>> register(
      RegisterRequestModel request);
}