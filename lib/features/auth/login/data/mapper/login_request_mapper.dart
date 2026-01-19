import '../../domain/entities/login_request_entity.dart';
import '../models/login_request_model/login_request_model.dart';

extension LoginRequestEntityMapper on LoginRequestEntity {
  LoginRequestModel toModel() {
    return LoginRequestModel(
      email: email,
      password: password,
    );
  }
}
