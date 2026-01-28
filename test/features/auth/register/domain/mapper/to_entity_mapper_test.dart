import 'package:flower_app/features/auth/register/data/mapper/to_entity_mapper.dart';
import 'package:flower_app/features/auth/register/data/models/register_response/register_response.dart';
import 'package:flower_app/features/auth/register/data/models/register_response/user.dart';
import 'package:flower_app/features/auth/register/domain/entities/register_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterEntity Mapper', () {
    test('should map RegisterResponse Model to Register Entity correctly', () {
      // Arrange
      final user = User(
        firstName: 'Omar',
        lastName: 'Ahmed',
        email: 'omar@gmail.com',
        gender: 'male',
        phone: '0123456789',
        createdAt: DateTime.now(),
      );

      final responseModel = RegisterResponseModel(
        message: 'success',
        user: user,
        token: 'token',
      );

      // Act
      final entity = responseModel.toEntity();

      // Assert
      expect(entity, isA<RegisterEntity>());
      expect(entity.message, 'success');
      expect(entity.token, 'token');

      expect(entity.user.firstName, user.firstName);
      expect(entity.user.lastName, user.lastName);
      expect(entity.user.email, user.email);
      expect(entity.user.phone, user.phone);
      expect(entity.user.gender, user.gender);
    });
  });
}
