import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/city_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/location_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/state_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/add_address_usecase.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/get_cities_by_state_use_case.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/get_coordinates_from_address_usecase.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/get_current_location_usecase.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/get_states_uescase.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/usecases/update_address_usecase.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view_model/add_update_addresse_cubit.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view_model/add_update_addresse_events.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view_model/add_update_addresse_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_update_addresse_cubit_test.mocks.dart';

@GenerateMocks([
  GetCurrentLocationUsecase,
  AddAddressUsecase,
  UpdateAddressUsecase,
  GetStatesUescase,
  GetCitiesByStateUseCase,
  GetCoordinatesFromAddressUseCase,
])
void main() {
  late AddUpdateAddresseCubit cubit;
  late MockGetCurrentLocationUsecase mockGetCurrentLocationUseCase;
  late MockAddAddressUsecase mockAddAddressUsecase;
  late MockUpdateAddressUsecase mockUpdateAddressUsecase;
  late MockGetStatesUescase mockGetStatesUescase;
  late MockGetCitiesByStateUseCase mockGetCitiesByStateUseCase;
  late MockGetCoordinatesFromAddressUseCase
  mockGetCoordinatesFromAddressUseCase;

  setUp(() {
    mockGetCurrentLocationUseCase = MockGetCurrentLocationUsecase();
    mockAddAddressUsecase = MockAddAddressUsecase();
    mockUpdateAddressUsecase = MockUpdateAddressUsecase();
    mockGetStatesUescase = MockGetStatesUescase();
    mockGetCitiesByStateUseCase = MockGetCitiesByStateUseCase();
    mockGetCoordinatesFromAddressUseCase =
        MockGetCoordinatesFromAddressUseCase();

    cubit = AddUpdateAddresseCubit(
      mockGetCurrentLocationUseCase,
      mockAddAddressUsecase,
      mockUpdateAddressUsecase,
      mockGetStatesUescase,
      mockGetCitiesByStateUseCase,
      mockGetCoordinatesFromAddressUseCase,
    );
  });

  tearDown(() => cubit.close());

  group('AddUpdateAddresseCubit', () {
    const mockLocation = LocationEntity(
      latitude: 30.0444,
      longitude: 31.2357,
      city: 'Cairo',
      state: 'Cairo Governorate',
    );

    final mockStates = [
      const StateEntity(
        id: '1',
        governorateNameAr: 'القاهرة',
        governorateNameEn: 'Cairo',
      ),
    ];

    final mockCities = [
      const CityEntity(
        id: '1',
        governorateId: '1',
        cityNameAr: 'مدينة نصر',
        cityNameEn: 'Nasr City',
      ),
    ];

    const mockAddressResponse = AddUpdateAddressResponseEntity(
      message: 'Address added successfully',
      address: [
        AddressEntity(
          id: '123',
          street: 'Test Street',
          phone: '01234567890',
          city: 'Cairo',
          lat: '30.0444',
          long: '31.2357',
          username: 'Test User',
        ),
      ],
    );

    test('initial state should have all states as null', () {
      expect(cubit.state.locationState, isNull);
      expect(cubit.state.governoratesState, isNull);
      expect(cubit.state.citiesState, isNull);
      expect(cubit.state.addUpdateState, isNull);
    });

    group('LoadInitialDataEvent', () {
      blocTest<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
        'emits loading states for both location and governorates',
        build: () {
          when(
            mockGetCurrentLocationUseCase.call(),
          ).thenAnswer((_) async => const BaseResponse.success(mockLocation));
          when(
            mockGetStatesUescase.call(),
          ).thenAnswer((_) async => BaseResponse.success(mockStates));
          return cubit;
        },
        act: (cubit) => cubit.onEvent(LoadInitialDataEvent()),
        expect: () => [
          predicate<AddUpdateAddresseStates>((state) {
            return state.locationState?.isLoading == true;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.governoratesState?.isLoading == true;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.locationState?.isLoading == false &&
                state.locationState?.data != null;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.governoratesState?.isLoading == false &&
                state.governoratesState?.data != null;
          }),
        ],
        verify: (_) {
          verify(mockGetCurrentLocationUseCase.call()).called(1);
          verify(mockGetStatesUescase.call()).called(1);
        },
      );
    });

    group('GetCurrentLocationEvent', () {
      blocTest<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
        'emits [loading, success] when getting current location succeeds',
        build: () {
          when(
            mockGetCurrentLocationUseCase.call(),
          ).thenAnswer((_) async => const BaseResponse.success(mockLocation));
          return cubit;
        },
        act: (cubit) => cubit.onEvent(GetCurrentLocationEvent()),
        expect: () => [
          predicate<AddUpdateAddresseStates>((state) {
            return state.locationState?.isLoading == true &&
                state.locationState?.data == null &&
                state.locationState?.errorMessage == null;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.locationState?.isLoading == false &&
                state.locationState?.data != null &&
                state.locationState?.errorMessage == null;
          }),
        ],
        verify: (_) {
          verify(mockGetCurrentLocationUseCase.call()).called(1);
        },
      );

      blocTest<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
        'emits [loading, failure] when getting current location fails',
        build: () {
          when(mockGetCurrentLocationUseCase.call()).thenAnswer(
            (_) async =>
                BaseResponse.failure(ErrorHandler.handle('Location error')),
          );
          return cubit;
        },
        act: (cubit) => cubit.onEvent(GetCurrentLocationEvent()),
        expect: () => [
          predicate<AddUpdateAddresseStates>((state) {
            return state.locationState?.isLoading == true;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.locationState?.isLoading == false &&
                state.locationState?.data == null &&
                state.locationState?.errorMessage != null;
          }),
        ],
        verify: (_) {
          verify(mockGetCurrentLocationUseCase.call()).called(1);
        },
      );
    });

    group('AddAddressEvent', () {
      final requestEntity = AddUpdateAddressRequestEntity(
        street: 'Test Street',
        phone: '01234567890',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
        username: 'Test User',
      );

      blocTest<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
        'emits [loading, success] when adding address succeeds',
        build: () {
          when(mockAddAddressUsecase.call(requestEntity)).thenAnswer(
            (_) async => const BaseResponse.success(mockAddressResponse),
          );
          return cubit;
        },
        act: (cubit) => cubit.onEvent(AddAddressEvent(address: requestEntity)),
        expect: () => [
          predicate<AddUpdateAddresseStates>((state) {
            return state.addUpdateState?.isLoading == true &&
                state.addUpdateState?.data == null;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.addUpdateState?.isLoading == false &&
                state.addUpdateState?.data != null;
          }),
        ],
        verify: (_) {
          verify(mockAddAddressUsecase.call(requestEntity)).called(1);
        },
      );

      blocTest<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
        'emits [loading, failure] when adding address fails',
        build: () {
          when(mockAddAddressUsecase.call(requestEntity)).thenAnswer(
            (_) async =>
                BaseResponse.failure(ErrorHandler.handle('Add address failed')),
          );
          return cubit;
        },
        act: (cubit) => cubit.onEvent(AddAddressEvent(address: requestEntity)),
        expect: () => [
          predicate<AddUpdateAddresseStates>((state) {
            return state.addUpdateState?.isLoading == true;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.addUpdateState?.isLoading == false &&
                state.addUpdateState?.errorMessage != null;
          }),
        ],
        verify: (_) {
          verify(mockAddAddressUsecase.call(requestEntity)).called(1);
        },
      );
    });

    group('UpdateAddressEvent', () {
      final requestEntity = AddUpdateAddressRequestEntity(
        street: 'Updated Street',
        phone: '01234567890',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
        username: 'Updated User',
      );
      const addressId = 'test-id-123';

      blocTest<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
        'emits [loading, success] when updating address succeeds',
        build: () {
          when(
            mockUpdateAddressUsecase.call(requestEntity, addressId),
          ).thenAnswer(
            (_) async => const BaseResponse.success(mockAddressResponse),
          );
          return cubit;
        },
        act: (cubit) => cubit.onEvent(
          UpdateAddressEvent(address: requestEntity, id: addressId),
        ),
        expect: () => [
          predicate<AddUpdateAddresseStates>((state) {
            return state.addUpdateState?.isLoading == true;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.addUpdateState?.isLoading == false &&
                state.addUpdateState?.data != null;
          }),
        ],
        verify: (_) {
          verify(
            mockUpdateAddressUsecase.call(requestEntity, addressId),
          ).called(1);
        },
      );
    });

    group('GetGovernoratesEvent', () {
      blocTest<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
        'emits [loading, success] when getting governorates succeeds',
        build: () {
          when(
            mockGetStatesUescase.call(),
          ).thenAnswer((_) async => BaseResponse.success(mockStates));
          return cubit;
        },
        act: (cubit) => cubit.onEvent(GetGovernoratesEvent()),
        expect: () => [
          predicate<AddUpdateAddresseStates>((state) {
            return state.governoratesState?.isLoading == true;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.governoratesState?.isLoading == false &&
                state.governoratesState?.data != null;
          }),
        ],
        verify: (_) {
          verify(mockGetStatesUescase.call()).called(1);
        },
      );
    });

    group('GetCitiesEvent', () {
      const governorateId = '1';

      blocTest<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
        'emits [loading, success] when getting cities succeeds',
        build: () {
          when(
            mockGetCitiesByStateUseCase.call(governorateId),
          ).thenAnswer((_) async => BaseResponse.success(mockCities));
          return cubit;
        },
        act: (cubit) =>
            cubit.onEvent(GetCitiesEvent(governorateId: governorateId)),
        expect: () => [
          predicate<AddUpdateAddresseStates>((state) {
            return state.citiesState?.isLoading == true;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.citiesState?.isLoading == false &&
                state.citiesState?.data != null;
          }),
        ],
        verify: (_) {
          verify(mockGetCitiesByStateUseCase.call(governorateId)).called(1);
        },
      );
    });

    group('OnCityChangedEvent', () {
      const cityName = 'Cairo';
      const stateName = 'Cairo Governorate';

      blocTest<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
        'emits [loading, success] when getting coordinates succeeds',
        build: () {
          when(
            mockGetCoordinatesFromAddressUseCase.call(
              cityName: stateName,
              stateName: cityName,
            ),
          ).thenAnswer((_) async => const BaseResponse.success(mockLocation));
          return cubit;
        },
        act: (cubit) => cubit.onEvent(
          OnCityChangedEvent(stateName: stateName, cityName: cityName),
        ),
        expect: () => [
          predicate<AddUpdateAddresseStates>((state) {
            return state.locationState?.isLoading == true;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.locationState?.isLoading == false &&
                state.locationState?.data != null;
          }),
        ],
        verify: (_) {
          verify(
            mockGetCoordinatesFromAddressUseCase.call(
              cityName: stateName,
              stateName: cityName,
            ),
          ).called(1);
        },
      );

      blocTest<AddUpdateAddresseCubit, AddUpdateAddresseStates>(
        'emits [loading, failure] when getting coordinates fails',
        build: () {
          when(
            mockGetCoordinatesFromAddressUseCase.call(
              cityName: stateName,
              stateName: cityName,
            ),
          ).thenAnswer(
            (_) async => BaseResponse.failure(
              ErrorHandler.handle('Coordinates not found'),
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.onEvent(
          OnCityChangedEvent(stateName: stateName, cityName: cityName),
        ),
        expect: () => [
          predicate<AddUpdateAddresseStates>((state) {
            return state.locationState?.isLoading == true;
          }),
          predicate<AddUpdateAddresseStates>((state) {
            return state.locationState?.isLoading == false &&
                state.locationState?.errorMessage != null;
          }),
        ],
        verify: (_) {
          verify(
            mockGetCoordinatesFromAddressUseCase.call(
              cityName: stateName,
              stateName: cityName,
            ),
          ).called(1);
        },
      );
    });
  });
}
