import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/features/auth/register/data/models/register_response/user.dart';
import 'package:online_exam_app/features/auth/register/domain/usecases/register_use_case.dart';
import 'package:online_exam_app/features/auth/register/domain/repositories/register_repository.dart';
import 'package:online_exam_app/features/auth/register/domain/entities/register_entity.dart';
import 'package:online_exam_app/features/auth/register/data/models/register_request/register_request.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';

import 'register_use_case_test.mocks.dart';

@GenerateMocks([RegisterRepository])
void main() {
  late RegisterUseCase useCase;
  late MockRegisterRepository mockRepository;

  final request = RegisterRequestModel(
    email: "omar@gmail.com",
    firstName: "Omar",
    lastName: "Ahmed",
    password: "123456",
    rePassword: "123456",
    phone: "0123456789",
    gender: "male",
  );

  final entity = RegisterEntity(
    token: "token",
    user: User(
      firstName: "Omar",
      lastName: "Ahmed",
      email: "omar@gmail.com",
      gender: "male",
      phone: "0123456789",
    ),
    message: "successful",
  );

  setUp(() {
    mockRepository = MockRegisterRepository();
    useCase = RegisterUseCase(mockRepository);
  });

  group('Register UseCase Senarios', () {
    test('should return success when repository returns success', () async {
      // Arrange
      when(
        mockRepository.register(request),
      ).thenAnswer((_) async => BaseResponse.success(entity));

      // Act
      final result = await useCase(request);

      // Assert
      result.when(
        success: (data) {
          expect(data, entity);
        },
        failure: (_) => fail('Expected success'),
      );

      verify(mockRepository.register(request)).called(1);
    });

    test('should return failure when repository returns failure', () async {
      // Arrange
      when(mockRepository.register(request)).thenAnswer(
        (_) async => BaseResponse.failure(
          ErrorHandler.handle(Exception('Register failed')),
        ),
      );

      // Act
      final result = await useCase(request);

      // Assert
      result.when(
        success: (_) => fail('Expected failure'),
        failure: (error) {
          expect(error.message, isNotEmpty);
        },
      );

      verify(mockRepository.register(request)).called(1);
    });
  });
}
