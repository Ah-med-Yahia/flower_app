import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/cart/cart_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/cash_order_entity/cache_order_response_entity.dart';
import 'package:flower_app/features/checkout/domain/use_cases/add_cache_order_use_case.dart';
import 'package:flower_app/features/checkout/domain/use_cases/add_credit_card_use_case.dart';
import 'package:flower_app/features/checkout/domain/use_cases/get_adresses_use_case.dart';
import 'package:flower_app/features/checkout/domain/use_cases/get_cart_info_use_case.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_intents.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_states.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_ui_intents.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'checkout_cubit_test.mocks.dart';

@GenerateMocks([
  GetAdressesUseCase,
  GetCartInfoUseCase,
  AddCacheOrderUseCase,
  AddCreditCardUseCase,
])
void main() {
  late CheckoutCubit cubit;
  late MockGetAdressesUseCase mockGetAdressesUseCase;
  late MockGetCartInfoUseCase mockGetCartInfoUseCase;
  late MockAddCacheOrderUseCase mockAddCacheOrderUseCase;
  late MockAddCreditCardUseCase mockAddCreditCardUseCase;

  setUp(() {
    mockGetAdressesUseCase = MockGetAdressesUseCase();
    mockGetCartInfoUseCase = MockGetCartInfoUseCase();
    mockAddCacheOrderUseCase = MockAddCacheOrderUseCase();
    mockAddCreditCardUseCase = MockAddCreditCardUseCase();

    cubit = CheckoutCubit(
      mockGetAdressesUseCase,
      mockGetCartInfoUseCase,
      mockAddCacheOrderUseCase,
      mockAddCreditCardUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  const tAddress = AddressEntity(id: '1', street: 'Street');
  const List<AddressEntity> tAddresses = [tAddress];
  const tCart = CartEntity(totalPrice: 100);

  group('CheckoutCubit', () {
    test('initial state should be CheckoutStates', () {
      expect(cubit.state, const CheckoutStates());
    });

    group('GetAdresses Intent (Initialization)', () {
      blocTest<CheckoutCubit, CheckoutStates>(
        'should emit [isLoading=true, state with data] when GetAdresses succeeds',
        build: () {
          when(
            mockGetAdressesUseCase(),
          ).thenAnswer((_) async => const BaseResponse.success(tAddresses));
          when(
            mockGetCartInfoUseCase(),
          ).thenAnswer((_) async => const BaseResponse.success(tCart));
          return cubit;
        },
        act: (cubit) => cubit.doIntent(GetAdresses()),
        expect: () => [
          const CheckoutStates(isLoading: true),
          const CheckoutStates(
            isLoading: false,
            addresses: tAddresses,
            selectedAddress: tAddress,
            cart: tCart,
          ),
        ],
        verify: (_) {
          verify(mockGetAdressesUseCase()).called(1);
          verify(mockGetCartInfoUseCase()).called(1);
        },
      );
    });

    group('PlaceOrderIntent', () {
      setUp(() {
        cubit.emit(
          cubit.state.copyWith(cart: tCart, selectedAddress: tAddress),
        );
      });

      test('should emit ShowErrorIntent if cart is empty', () async {
        cubit.emit(cubit.state.copyWith(cart: const CartEntity(totalPrice: 0)));

        final expectedStates = [isA<ShowErrorIntent>()];

        expectLater(cubit.uiIntent, emitsInOrder(expectedStates));

        cubit.doIntent(PlaceOrderIntent());
      });

      test(
        'should place cash order successfully and emit UI intents',
        () async {
          // Arrange
          when(mockAddCacheOrderUseCase(any)).thenAnswer(
            (_) async => BaseResponse.success(
              CacheOrderResponseEntity(message: 'Success'),
            ),
          );

          cubit.emit(
            cubit.state.copyWith(
              cart: tCart,
              selectedAddress: tAddress,
              selectedPaymentMethod: AppTextConstants.cash,
            ),
          );

          // Assert
          expectLater(
            cubit.uiIntent,
            emitsInOrder([
              isA<ShowLoadingIntent>(),
              isA<HideLoadingIntent>(),
              isA<NavigateToSuccessIntent>(),
            ]),
          );

          cubit.doIntent(PlaceOrderIntent());

          await untilCalled(mockAddCacheOrderUseCase(any));

          verify(mockAddCacheOrderUseCase(any)).called(1);
        },
      );
    });
  });
}
