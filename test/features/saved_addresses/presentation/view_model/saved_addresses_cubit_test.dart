import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/domain/usecases/delete_saved_address_usecase.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/domain/usecases/get_all_saved_addresses_usecase.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_cubit.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_events.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_states.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view_model/saved_addresses_ui_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'saved_addresses_cubit_test.mocks.dart';

@GenerateMocks([GetAllSavedAddressesUsecase, DeleteSavedAddressUsecase])
Future<void> main() async {
  late SavedAddressesCubit cubit;
  late MockGetAllSavedAddressesUsecase mockGetAllUsecase;
  late MockDeleteSavedAddressUsecase mockDeleteUsecase;

  setUp(() {
    mockGetAllUsecase = MockGetAllSavedAddressesUsecase();
    mockDeleteUsecase = MockDeleteSavedAddressUsecase();
    cubit = SavedAddressesCubit(mockGetAllUsecase, mockDeleteUsecase);
  });

  tearDown(() => cubit.close());

  const mockAddressEntity = AddressEntity(
    id: '1',
    street: 'Test Street',
    phone: '01234567890',
    city: 'Test City',
    lat: '30.123',
    long: '31.456',
    username: 'testuser',
  );

  const mockSavedAddressesData = SavedAddressesResponseEntity(
    message: 'success',
    addresses: [mockAddressEntity],
  );

  group('getSavedAddresses', () {
    test('initial state should have null savedAddressesState', () {
      expect(cubit.state.savedAddressesState, isNull);
    });

    blocTest<SavedAddressesCubit, SavedAddressesStates>(
      'emits [loading, success] when getting saved addresses succeeds',
      build: () {
        when(mockGetAllUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockSavedAddressesData),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetSavedAddressesEvent()),
      expect: () => [
        predicate<SavedAddressesStates>((state) {
          return state.savedAddressesState?.isLoading == true &&
              state.savedAddressesState?.data == null &&
              state.savedAddressesState?.errorMessage == null;
        }),
        predicate<SavedAddressesStates>((state) {
          return state.savedAddressesState?.isLoading == false &&
              state.savedAddressesState?.data != null &&
              state.savedAddressesState?.errorMessage == null;
        }),
      ],
      verify: (_) {
        verify(mockGetAllUsecase.call()).called(1);
      },
    );

    blocTest<SavedAddressesCubit, SavedAddressesStates>(
      'emits [loading, failure] when getting saved addresses fails',
      build: () {
        when(mockGetAllUsecase.call()).thenAnswer(
          (_) async =>
              BaseResponse.failure(ErrorHandler.handle('Something went wrong')),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetSavedAddressesEvent()),
      expect: () => [
        predicate<SavedAddressesStates>((state) {
          return state.savedAddressesState?.isLoading == true &&
              state.savedAddressesState?.data == null &&
              state.savedAddressesState?.errorMessage == null;
        }),
        predicate<SavedAddressesStates>((state) {
          return state.savedAddressesState?.isLoading == false &&
              state.savedAddressesState?.data == null &&
              state.savedAddressesState?.errorMessage != null;
        }),
      ],
      verify: (_) {
        verify(mockGetAllUsecase.call()).called(1);
      },
    );
  });

  group('deleteSavedAddress', () {
    const addressId = '1';

    blocTest<SavedAddressesCubit, SavedAddressesStates>(
      'emits [loading, success] when deleting address succeeds',
      build: () {
        when(mockDeleteUsecase.call(addressId)).thenAnswer(
          (_) async => const BaseResponse.success(mockSavedAddressesData),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(DeleteSavedAddressEvent(addressId)),
      expect: () => [
        predicate<SavedAddressesStates>((state) {
          return state.savedAddressesState?.isLoading == true &&
              state.savedAddressesState?.errorMessage == null;
        }),
        predicate<SavedAddressesStates>((state) {
          return state.savedAddressesState?.isLoading == false &&
              state.savedAddressesState?.data != null &&
              state.savedAddressesState?.errorMessage == null;
        }),
      ],
      verify: (_) {
        verify(mockDeleteUsecase.call(addressId)).called(1);
      },
    );

    blocTest<SavedAddressesCubit, SavedAddressesStates>(
      'emits [loading, failure] when deleting address fails',
      build: () {
        when(mockDeleteUsecase.call(addressId)).thenAnswer(
          (_) async => BaseResponse.failure(
            ErrorHandler.handle('Failed to delete address'),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(DeleteSavedAddressEvent(addressId)),
      expect: () => [
        predicate<SavedAddressesStates>((state) {
          return state.savedAddressesState?.isLoading == true &&
              state.savedAddressesState?.errorMessage == null;
        }),
        predicate<SavedAddressesStates>((state) {
          return state.savedAddressesState?.isLoading == false &&
              state.savedAddressesState?.errorMessage != null;
        }),
      ],
      verify: (_) {
        verify(mockDeleteUsecase.call(addressId)).called(1);
      },
    );
  });

  group('navigation events', () {
    blocTest<SavedAddressesCubit, SavedAddressesStates>(
      'emits navigation event when AddNewAddressEvent is triggered',
      build: () => cubit,
      act: (cubit) => cubit.onEvent(AddNewAddressEvent()),
      expect: () => [
        predicate<SavedAddressesStates>((state) {
          return state.navigationEvent is NavigateToAddUpdateAddressUiEvent &&
              (state.navigationEvent as NavigateToAddUpdateAddressUiEvent)
                      .address ==
                  null;
        }),
      ],
    );

    blocTest<SavedAddressesCubit, SavedAddressesStates>(
      'emits navigation event when EditSavedAddressEvent is triggered',
      build: () => cubit,
      act: (cubit) => cubit.onEvent(
        EditSavedAddressEvent(
          const AddressEntity(
            id: '123',
            street: 'Test Street',
            phone: '01234567890',
            city: 'Test City',
            lat: '30.123',
            long: '31.456',
            username: 'testuser',
          ),
        ),
      ),
      expect: () => [
        predicate<SavedAddressesStates>((state) {
          return state.navigationEvent is NavigateToAddUpdateAddressUiEvent &&
              (state.navigationEvent as NavigateToAddUpdateAddressUiEvent)
                      .address ==
                  const AddressEntity(
                    id: '123',
                    street: 'Test Street',
                    phone: '01234567890',
                    city: 'Test City',
                    lat: '30.123',
                    long: '31.456',
                    username: 'testuser',
                  );
        }),
      ],
    );
  });
}
