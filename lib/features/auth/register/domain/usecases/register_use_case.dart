import 'package:flower_app/features/auth/register/domain/entities/register_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../data/models/register_request/register_request.dart';
import '../repositories/register_repository.dart';

@injectable
class RegisterUseCase {
  final RegisterRepository registerRepository;

  RegisterUseCase(this.registerRepository);

  Future<BaseResponse<RegisterEntity>> call(
    RegisterRequestModel request,
  ) {
    return registerRepository.register(request);
  }
}
