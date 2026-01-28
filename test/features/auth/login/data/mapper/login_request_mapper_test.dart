import 'package:flower_app/features/auth/login/data/mapper/login_request_mapper.dart';
import 'package:flower_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:test/test.dart';

void main() {
  test('LoginRequestEntity.toModel should map fields correctly', () {
    final entity = LoginRequestEntity(
      email: 'test@test.com',
      password: '123456',
    );

    final model = entity.toModel();

    expect(model.email, entity.email);
    expect(model.password, entity.password);
  });
}
