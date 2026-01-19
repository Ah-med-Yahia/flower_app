import '../models/register_response/register_response.dart';
import '../../domain/entities/register_entity.dart';

extension ToEntity on RegisterResponseModel {
  RegisterEntity toEntity() {
    return RegisterEntity(
      message: message,
      user: user,
      token: token,
    );
  }
}