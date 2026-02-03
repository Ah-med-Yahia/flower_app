import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/location_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/repo/add_update_address_repo.dart';
import 'package:flower_app/features/add_update_adrees/domain/usecases/get_coordinates_from_address_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_coordinates_from_address_usecase_test.mocks.dart';

@GenerateMocks([AddUpdateAddressRepo])
void main() {
  late GetCoordinatesFromAddressUseCase useCase;
  late MockAddUpdateAddressRepo mockRepo;

  setUp(() {
    mockRepo = MockAddUpdateAddressRepo();
    useCase = GetCoordinatesFromAddressUseCase(mockRepo);
  });

  group('GetCoordinatesFromAddressUseCase', () {
    const cityName = 'Cairo';
    const stateName = 'Cairo Governorate';

    const locationEntity = LocationEntity(
      latitude: 30.0444,
      longitude: 31.2357,
      city: cityName,
      state: stateName,
    );

    test(
      'should return location when both city and state are provided',
      () async {
        // Arrange
        when(
          mockRepo.getCoordinatesFromAddress(
            cityName: cityName,
            stateName: stateName,
          ),
        ).thenAnswer((_) async => BaseResponse.success(locationEntity));

        // Act
        final result = await useCase.call(
          cityName: cityName,
          stateName: stateName,
        );

        // Assert
        expect(result, isA<BaseResponse<LocationEntity>>());
        result.when(
          success: (location) {
            expect(location.latitude, 30.0444);
            expect(location.longitude, 31.2357);
            expect(location.city, cityName);
            expect(location.state, stateName);
          },
          failure: (_) => fail('Expected success but got failure'),
        );

        verify(
          mockRepo.getCoordinatesFromAddress(
            cityName: cityName,
            stateName: stateName,
          ),
        ).called(1);
      },
    );

    test('should return location when only state is provided', () async {
      // Arrange
      const stateOnlyLocation = LocationEntity(
        latitude: 30.0444,
        longitude: 31.2357,
        state: stateName,
      );

      when(
        mockRepo.getCoordinatesFromAddress(cityName: '', stateName: stateName),
      ).thenAnswer((_) async => BaseResponse.success(stateOnlyLocation));

      // Act
      final result = await useCase.call(cityName: '', stateName: stateName);

      // Assert
      expect(result, isA<BaseResponse<LocationEntity>>());
      result.when(
        success: (location) {
          expect(location.latitude, 30.0444);
          expect(location.longitude, 31.2357);
          expect(location.state, stateName);
        },
        failure: (_) => fail('Expected success but got failure'),
      );

      verify(
        mockRepo.getCoordinatesFromAddress(cityName: '', stateName: stateName),
      ).called(1);
    });

    test('should return failure when state name is empty', () async {
      // Act
      final result = await useCase.call(cityName: cityName, stateName: '');

      // Assert
      expect(result, isA<BaseResponse<LocationEntity>>());
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ErrorHandler>());
        },
      );

      verifyNever(
        mockRepo.getCoordinatesFromAddress(
          cityName: anyNamed('cityName'),
          stateName: anyNamed('stateName'),
        ),
      );
    });

    test('should return failure when repository fails', () async {
      // Arrange
      when(
        mockRepo.getCoordinatesFromAddress(
          cityName: cityName,
          stateName: stateName,
        ),
      ).thenAnswer(
        (_) async =>
            BaseResponse.failure(ErrorHandler.handle('Location not found')),
      );

      // Act
      final result = await useCase.call(
        cityName: cityName,
        stateName: stateName,
      );

      // Assert
      expect(result, isA<BaseResponse<LocationEntity>>());
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ErrorHandler>());
        },
      );

      verify(
        mockRepo.getCoordinatesFromAddress(
          cityName: cityName,
          stateName: stateName,
        ),
      ).called(1);
    });

    test('should validate state name before calling repository', () async {
      // Act
      final result = await useCase.call(cityName: 'Some City', stateName: '');

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ErrorHandler>());
        },
      );

      // Verify repository was never called
      verifyZeroInteractions(mockRepo);
    });
  });
}
