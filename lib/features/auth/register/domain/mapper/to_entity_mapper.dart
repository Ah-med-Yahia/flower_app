import '../../data/models/register_response/register_response.dart';
import '../entities/register_entity.dart';

extension ToEntity on RegisterResponseModel {
  RegisterEntity toEntity() {
    return RegisterEntity(
      message: message,
      user: user,
      token: token,
    );
  }
}