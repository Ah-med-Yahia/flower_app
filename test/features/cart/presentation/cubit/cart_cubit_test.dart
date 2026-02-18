import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared/data/models/message_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/tabs/cart/domain/entities/cart_entity/cart_entity.dart';
import 'package:flower_app/features/tabs/cart/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:flower_app/features/tabs/cart/domain/entities/cart_entity/cart_product_entity.dart';
import 'package:flower_app/features/tabs/cart/domain/entities/get_cart_response_entity.dart';
import 'package:flower_app/features/tabs/cart/domain/entities/update_item_quantity_request_entity.dart';
import 'package:flower_app/features/tabs/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:flower_app/features/tabs/cart/domain/usecases/get_cart_use_case.dart';
import 'package:flower_app/features/tabs/cart/domain/usecases/remove_item_from_cart_use_case.dart';
import 'package:flower_app/features/tabs/cart/domain/usecases/update_item_quantity_use_case.dart';
import 'package:flower_app/features/tabs/cart/presentation/cubit/cart_cubit.dart';
import 'package:flower_app/features/tabs/cart/presentation/cubit/cart_event_ui.dart';
import 'package:flower_app/features/tabs/cart/presentation/cubit/cart_intents.dart';
import 'package:flower_app/features/tabs/cart/presentation/cubit/cart_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_cubit_test.mocks.dart';

@GenerateMocks([
  ClearCartUseCase,
  GetCartUseCase,
  RemoveItemFromCartUseCase,
  UpdateItemQuantityUseCase,
])
void main() {
  late CartCubit cubit;
  late MockClearCartUseCase mockClearCartUseCase;
  late MockGetCartUseCase mockGetCartUseCase;
  late MockRemoveItemFromCartUseCase mockRemoveItemFromCartUseCase;
  late MockUpdateItemQuantityUseCase mockUpdateItemQuantityUseCase;

  setUp(() {
    mockClearCartUseCase = MockClearCartUseCase();
    mockGetCartUseCase = MockGetCartUseCase();
    mockRemoveItemFromCartUseCase = MockRemoveItemFromCartUseCase();
    mockUpdateItemQuantityUseCase = MockUpdateItemQuantityUseCase();
    cubit = CartCubit(
      mockClearCartUseCase,
      mockGetCartUseCase,
      mockRemoveItemFromCartUseCase,
      mockUpdateItemQuantityUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  const tCartProductEntity = CartProductEntity(
    title: 'Rose',
    slug: 'rose',
    description: 'Red rose',
    imgCover: 'img.jpg',
    images: ['img1.jpg'],
    price: 100,
    priceAfterDiscount: 90,
    quantity: 10,
    category: 'flowers',
    occasion: 'love',
    productId: 'prod123',
  );

  const tCartItemEntity = CartItemEntity(
    product: tCartProductEntity,
    price: 90,
    quantity: 2,
    id: 'item1',
  );

  const tCartEntity = CartEntity(
    cartItems: [tCartItemEntity],
    appliedCoupons: [],
    totalPrice: 180,
  );

  const tGetCartResponseEntity = GetCartResponseEntity(
    message: 'Success',
    numOfCartItems: 1,
    cart: tCartEntity,
  );

  const tEmptyCartEntity = CartEntity(
    cartItems: [],
    appliedCoupons: [],
    totalPrice: 0,
  );

  const tEmptyGetCartResponse = GetCartResponseEntity(
    message: 'Cart Cleared',
    numOfCartItems: 0,
    cart: tEmptyCartEntity,
  );

  const tUpdateItemQuantityRequestEntity = UpdateItemQuantityRequestEntity(
    quantity: 5,
  );

  const tMessageResponse = MessageResponse(message: 'Cart Cleared');

  final tErrorHandler = ErrorHandler.handle('Error Message');

  group('CartCubit -', () {
    group('GetCartIntent -', () {
      blocTest<CartCubit, CartState>(
        'should emit [CartState(cartBaseState: ...)] with data when successful',
        build: () {
          when(mockGetCartUseCase.call()).thenAnswer(
            (_) async => const BaseResponse.success(tGetCartResponseEntity),
          );
          return cubit;
        },
        act: (cubit) => cubit.doIntent(GetCartIntent()),
        expect: () => [
          isA<CartState>().having(
            (state) => state.cartBaseState?.data,
            'cartBaseState.data',
            tGetCartResponseEntity,
          ),
        ],
        verify: (_) {
          verify(mockGetCartUseCase.call()).called(1);
        },
      );

      blocTest<CartCubit, CartState>(
        'should emit [CartState(cartBaseState: ...)] with isEmpty=true when cart is empty',
        build: () {
          when(mockGetCartUseCase.call()).thenAnswer(
            (_) async => const BaseResponse.success(tEmptyGetCartResponse),
          );
          return cubit;
        },
        act: (cubit) => cubit.doIntent(GetCartIntent()),
        expect: () => [
          isA<CartState>().having(
            (state) => state.cartBaseState?.isEmpty,
            'cartBaseState.isEmpty',
            true,
          ),
        ],
      );

      test(
        'should emit LoadingCart then ErrorGetCart UI events on failure',
        () async {
          when(
            mockGetCartUseCase.call(),
          ).thenAnswer((_) async => BaseResponse.failure(tErrorHandler));

          final uiEvents = <CartEventUI>[];
          final subscription = cubit.uiEvents.listen(uiEvents.add);

          await cubit.doIntent(GetCartIntent());

          await Future.delayed(Duration.zero);

          expect(uiEvents.length, 2);
          expect(uiEvents[0], isA<LoadingCart>());
          expect(uiEvents[1], isA<ErrorGetCart>());

          await subscription.cancel();
        },
      );

      test(
        'should emit LoadingCart then SuccessAfterLoading when success',
        () async {
          when(mockGetCartUseCase.call()).thenAnswer(
            (_) async => const BaseResponse.success(tGetCartResponseEntity),
          );

          final uiEvents = <CartEventUI>[];
          final subscription = cubit.uiEvents.listen(uiEvents.add);

          await cubit.doIntent(GetCartIntent());

          await Future.delayed(Duration.zero);

          expect(uiEvents.length, 2);
          expect(uiEvents[0], isA<LoadingCart>());
          expect(uiEvents[1], isA<SuccessAfterLoading>());

          await subscription.cancel();
        },
      );
    });

    group('UpdateItemQuantityIntent -', () {
      blocTest<CartCubit, CartState>(
        'should emit [CartState(cartBaseState: ...)] when successful',
        build: () {
          when(
            mockUpdateItemQuantityUseCase.call(
              productId: anyNamed('productId'),
              requestEntity: anyNamed('requestEntity'),
            ),
          ).thenAnswer(
            (_) async => const BaseResponse.success(tGetCartResponseEntity),
          );
          return cubit;
        },
        act: (cubit) => cubit.doIntent(
          UpdateItemQuantityIntent(
            productId: 'prod123',
            requestEntity: tUpdateItemQuantityRequestEntity,
          ),
        ),
        expect: () => [
          isA<CartState>().having(
            (state) => state.cartBaseState?.data,
            'cartBaseState.data',
            tGetCartResponseEntity,
          ),
        ],
        verify: (_) {
          verify(
            mockUpdateItemQuantityUseCase.call(
              productId: 'prod123',
              requestEntity: tUpdateItemQuantityRequestEntity,
            ),
          ).called(1);
        },
      );

      test('should emit ErrorCartItemsUpdate UI event on failure', () async {
        when(
          mockUpdateItemQuantityUseCase.call(
            productId: anyNamed('productId'),
            requestEntity: anyNamed('requestEntity'),
          ),
        ).thenAnswer((_) async => BaseResponse.failure(tErrorHandler));

        final uiEvents = <CartEventUI>[];
        final subscription = cubit.uiEvents.listen(uiEvents.add);

        await cubit.doIntent(
          UpdateItemQuantityIntent(
            productId: 'prod123',
            requestEntity: tUpdateItemQuantityRequestEntity,
          ),
        );

        await Future.delayed(Duration.zero);

        expect(uiEvents.length, 1);
        expect(uiEvents[0], isA<ErrorCartItemsUpdate>());

        await subscription.cancel();
      });
    });

    group('RemoveItemFromCartIntent -', () {
      blocTest<CartCubit, CartState>(
        'should emit [CartState(cartBaseState: ...)] when successful',
        build: () {
          when(
            mockRemoveItemFromCartUseCase.call(
              productId: anyNamed('productId'),
            ),
          ).thenAnswer(
            (_) async => const BaseResponse.success(tGetCartResponseEntity),
          );
          return cubit;
        },
        act: (cubit) =>
            cubit.doIntent(RemoveItemFromCartIntent(productId: 'prod123')),
        expect: () => [
          isA<CartState>().having(
            (state) => state.cartBaseState?.data,
            'cartBaseState.data',
            tGetCartResponseEntity,
          ),
        ],
        verify: (_) {
          verify(
            mockRemoveItemFromCartUseCase.call(productId: 'prod123'),
          ).called(1);
        },
      );

      blocTest<CartCubit, CartState>(
        'should emit [CartState(cartBaseState: ...)] with isEmpty=true when removing results in empty cart',
        build: () {
          when(
            mockRemoveItemFromCartUseCase.call(
              productId: anyNamed('productId'),
            ),
          ).thenAnswer(
            (_) async => const BaseResponse.success(tEmptyGetCartResponse),
          );
          return cubit;
        },
        act: (cubit) =>
            cubit.doIntent(RemoveItemFromCartIntent(productId: 'prod123')),
        expect: () => [
          isA<CartState>().having(
            (state) => state.cartBaseState?.isEmpty,
            'cartBaseState.isEmpty',
            true,
          ),
        ],
      );

      test('should emit ErrorCartItemsUpdate UI event on failure', () async {
        when(
          mockRemoveItemFromCartUseCase.call(productId: anyNamed('productId')),
        ).thenAnswer((_) async => BaseResponse.failure(tErrorHandler));

        final uiEvents = <CartEventUI>[];
        final subscription = cubit.uiEvents.listen(uiEvents.add);

        await cubit.doIntent(RemoveItemFromCartIntent(productId: 'prod123'));
        await Future.delayed(Duration.zero);

        expect(uiEvents.length, 1);
        expect(uiEvents[0], isA<ErrorCartItemsUpdate>());

        await subscription.cancel();
      });
    });

    group('ClearCartIntent -', () {
      blocTest<CartCubit, CartState>(
        'should emit [CartState(cartBaseState: ...)] with isEmpty=true when successful',
        build: () {
          when(mockClearCartUseCase.call()).thenAnswer(
            (_) async => const BaseResponse.success(tMessageResponse),
          );
          return cubit;
        },
        act: (cubit) => cubit.doIntent(ClearCartIntent()),
        expect: () => [
          isA<CartState>().having(
            (state) => state.cartBaseState?.isEmpty,
            'cartBaseState.isEmpty',
            true,
          ),
        ],
        verify: (_) {
          verify(mockClearCartUseCase.call()).called(1);
        },
      );

      test(
        'should emit LoadingCart then SuccessAfterLoading UI events on success',
        () async {
          when(mockClearCartUseCase.call()).thenAnswer(
            (_) async => const BaseResponse.success(tMessageResponse),
          );
          final uiEvents = <CartEventUI>[];
          final subscription = cubit.uiEvents.listen(uiEvents.add);

          await cubit.doIntent(ClearCartIntent());

          await Future.delayed(Duration.zero);

          expect(uiEvents.length, 2);
          expect(uiEvents[0], isA<LoadingCart>());
          expect(uiEvents[1], isA<SuccessAfterLoading>());
          expect((uiEvents[1] as SuccessAfterLoading).message, 'Cart Cleared');
          await subscription.cancel();
        },
      );

      test(
        'should emit LoadingCart then ErrorGetCart UI events on failure',
        () async {
          when(
            mockClearCartUseCase.call(),
          ).thenAnswer((_) async => BaseResponse.failure(tErrorHandler));
          final uiEvents = <CartEventUI>[];
          final subscription = cubit.uiEvents.listen(uiEvents.add);

          await cubit.doIntent(ClearCartIntent());

          await Future.delayed(Duration.zero);

          expect(uiEvents.length, 2);
          expect(uiEvents[0], isA<LoadingCart>());
          expect(uiEvents[1], isA<ErrorGetCart>());

          await subscription.cancel();
        },
      );
    });
  });
}
