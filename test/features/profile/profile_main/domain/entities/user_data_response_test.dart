import 'package:flower_app/features/profile/profile_main/domain/entities/user_data_response.dart';
import 'package:flower_app/features/profile/profile_main/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('All test cases scenarios of UserDataResponse', () {
    _testSuccessfulUserDataResponseWithSameQualityValue();
    _testSuccessfulUserDataResponseWithNotQualityValue();
  });
}

void _testSuccessfulUserDataResponseWithSameQualityValue() {
  test('When response is Success, '
      'should be support value equality', () {
    // Arrange
    const user = UserEntity(
      id: '1',
      firstName: 'John',
      email: 'john.c.calhoun@examplepetstore.com',
      imgAvatarURL: 'https://example.com/avatar.jpg',
    );

    const response1 = UserDataResponse('Success', user);
    const response2 = UserDataResponse('Success', user);

    // Act & Assert
    expect(response1, equals(response2));
  });
}

void _testSuccessfulUserDataResponseWithNotQualityValue() {
  test('When response is Success, '
      'should not be equal when properties differ', () {
    // Arrange
    const user1 = UserEntity(
      id: '1',
      firstName: 'John',
      email: 'john.c.calhoun@examplepetstore.com',
      imgAvatarURL: 'https://example.com/avatar.jpg',
    );
    const user2 = UserEntity(
      id: '2',
      firstName: 'John',
      email: 'john.c.calhoun@examplepetstore.com',
      imgAvatarURL: 'https://example.com/avatar.jpg',
    );

    const response1 = UserDataResponse('Success', user1);
    const response2 = UserDataResponse('Success', user2);

    // Act & Assert
    expect(response1, isNot(equals(response2)));
  });
}
