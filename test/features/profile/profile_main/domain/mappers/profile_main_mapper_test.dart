import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/user_data_response_dto.dart';
import 'package:flower_app/features/tabs/profile/profile_main/data/models/user_dto.dart';
import 'package:flower_app/features/tabs/profile/profile_main/domain/entities/user_data_response.dart';
import 'package:flower_app/features/tabs/profile/profile_main/domain/entities/user_entity.dart';
import 'package:flower_app/features/tabs/profile/profile_main/domain/mappers/profile_main_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('All test cases scenarios of ProfileMainMapper', () {
    _setupSuccessfulMappingScenarios();
    _setupNullValueHandlingScenarios();
  });
}

void _setupSuccessfulMappingScenarios() {
  group('Successful response mapping scenarios with correct data', () {
    _testMappingToUserDataResponseWithCorrectData();
    _testMappingToUserEntityWithCorrectData();
  });
}

void _setupNullValueHandlingScenarios() {
  group('Successful response mapping scenarios with null values', () {
    _testMappingToUserEntityWithNullData();
  });
}

void _testMappingToUserDataResponseWithCorrectData() {
  test('When response is Success, '
      'should be mapped with UserDataResponse correctly', () {
    final userDto = UserDto(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.c.calhoun@examplepetstore.com',
      phone: '1234567890',
      gender: 'Male',
      photo: 'https://example.com/avatar.jpg',
      role: 'user',
      createdAt: DateTime(2023, 1, 1),
      addresses: const [],
      wishlist: const [],
    );
    final responseDto = UserDataResponseDto(message: 'Success', user: userDto);

    final result = ProfileMainMapper.mapUserDataResponseDtoToUserDataResponse(
      responseDto,
    );

    expect(result, isA<UserDataResponse>());
    expect(result.message, 'Success');
    expect(result.user, isA<UserEntity>());
    expect(result.user.id, '1');
    expect(result.user.firstName, 'John');
    expect(result.user.email, 'john.c.calhoun@examplepetstore.com');
    expect(result.user.imgAvatarURL, 'https://example.com/avatar.jpg');
  });
}

void _testMappingToUserEntityWithCorrectData() {
  test('When response is Success, '
      'should be mapped with UserEntity correctly', () {
    final userDto = UserDto(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.c.calhoun@examplepetstore.com',
      phone: '1234567890',
      gender: 'Male',
      photo: 'https://example.com/avatar.jpg',
      role: 'user',
      createdAt: DateTime(2023, 1, 1),
      addresses: const [],
      wishlist: const [],
    );

    final result = ProfileMainMapper.mapUserDtoToUserEntity(userDto);

    expect(result, isA<UserEntity>());
    expect(result.id, '1');
    expect(result.firstName, 'John');
    expect(result.email, 'john.c.calhoun@examplepetstore.com');
    expect(result.imgAvatarURL, 'https://example.com/avatar.jpg');
  });
}

void _testMappingToUserEntityWithNullData() {
  test('When response is Success, '
      'with null data, should be mapped with UserEntity correctly', () {
    const UserDto? userDto = null;

    final result = ProfileMainMapper.mapUserDtoToUserEntity(
      userDto ?? UserDto(),
    );
    expect(result, isA<UserEntity>());
    expect(result.id, '');
    expect(result.firstName, '');
    expect(result.email, '');
    expect(result.imgAvatarURL, AppTextConstants.defaultAvatarUrl);
  });
}
