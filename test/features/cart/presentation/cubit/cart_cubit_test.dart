import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/cart/domain/entities/add_to_cart_request_entity.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_entity.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_product_entity.dart';
import 'package:flower_app/features/cart/domain/entities/clear_cart_response_entity.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_response_entity.dart';
import 'package:flower_app/features/cart/domain/entities/update_item_quantity_request_entity.dart';
import 'package:flower_app/features/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/usecases/get_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/usecases/remove_item_from_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/usecases/update_item_quantity_use_case.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_event_ui.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_intents.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_cubit_test.mocks.dart';

@GenerateMocks([
  AddToCartUseCase,
  ClearCartUseCase,
  GetCartUseCase,
  RemoveItemFromCartUseCase,
  UpdateItemQuantityUseCase,
])
void main() {
  late CartCubit cubit;
  late MockAddToCartUseCase mockAddToCartUseCase;
  late MockClearCartUseCase mockClearCartUseCase;
  late MockGetCartUseCase mockGetCartUseCase;
  late MockRemoveItemFromCartUseCase mockRemoveItemFromCartUseCase;
  late MockUpdateItemQuantityUseCase mockUpdateItemQuantityUseCase;

  setUp(() {
    mockAddToCartUseCase = MockAddToCartUseCase();
    mockClearCartUseCase = MockClearCartUseCase();
    mockGetCartUseCase = MockGetCartUseCase();
    mockRemoveItemFromCartUseCase = MockRemoveItemFromCartUseCase();
    mockUpdateItemQuantityUseCase = MockUpdateItemQuantityUseCase();
    cubit = CartCubit(
      mockAddToCartUseCase,
      mockClearCartUseCase,
      mockGetCartUseCase,
      mockRemoveItemFromCartUseCase,
      mockUpdateItemQuantityUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  final tCartProductEntity = CartProductEntity(
    id: 'p1',
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
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    isSuperAdmin: false,
    sold: 5,
    rateAvg: 4,
    rateCount: 10,
    productId: 'prod123',
  );

  final tCartItemEntity = CartItemEntity(
    product: tCartProductEntity,
    price: 90,
    quantity: 2,
    id: 'item1',
  );

  final tCartEntity = CartEntity(
    id: 'cart1',
    user: 'user1',
    cartItems: [tCartItemEntity],
    appliedCoupons: [],
    totalPrice: 180,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final tGetCartResponseEntity = GetCartResponseEntity(
    message: 'Success',
    numOfCartItems: 1,
    cart: tCartEntity,
  );

  final tClearCartResponseEntity = ClearCartResponseEntity(
    message: 'Cart Cleared',
  );

  final tAddToCartRequestEntity = AddToCartRequestEntity(
    productId: 'prod123',
    quantity: 2,
  );
  final tUpdateItemQuantityRequestEntity = UpdateItemQuantityRequestEntity(
    quantity: 5,
  );

  final tErrorHandler = ErrorHandler.handle('Error Message');

  group('CartCubit -', () {
    // ========================================
    // 1. Initial State Test
    // ========================================
    test('initial state should be CartState with null getCartResponse', () {
      expect(cubit.state, isA<CartState>());
      expect(cubit.state.getCartResponse, null);
    });

    group('GetCartIntent -', () {
      // ========================================
      // 2. GetCart Tests
      // ========================================
      blocTest<CartCubit, CartState>(
        'should emit [CartState(getCartResponse: ...)] when successful',
        build: () {
          when(mockGetCartUseCase.call()).thenAnswer(
            (_) async => BaseResponse.success(tGetCartResponseEntity),
          );
          return cubit;
        },
        act: (cubit) => cubit.doIntent(GetCartIntent()),
        expect: () => [
          isA<CartState>().having(
            (state) => state.getCartResponse,
            'getCartResponse',
            tGetCartResponseEntity,
          ),
        ],
        verify: (_) {
          verify(mockGetCartUseCase.call()).called(1);
        },
      );

      test('should emit LoadingCart then Error UI events on failure', () async {
        when(
          mockGetCartUseCase.call(),
        ).thenAnswer((_) async => BaseResponse.failure(tErrorHandler));

        final uiEvents = <CartEventUI>[];
        final subscription = cubit.uiEvents.listen(uiEvents.add);

        await cubit.doIntent(GetCartIntent());

        await Future.delayed(Duration.zero);

        expect(uiEvents.length, 2);
        expect(uiEvents[0], isA<LoadingCart>());
        expect(uiEvents[1], isA<Error>());

        await subscription.cancel();
      });

      test('should emit LoadingCart when success', () async {
        when(
          mockGetCartUseCase.call(),
        ).thenAnswer((_) async => BaseResponse.success(tGetCartResponseEntity));

        final uiEvents = <CartEventUI>[];
        final subscription = cubit.uiEvents.listen(uiEvents.add);

        await cubit.doIntent(GetCartIntent());

        await Future.delayed(Duration.zero);

        expect(uiEvents.length, 1);
        expect(uiEvents[0], isA<LoadingCart>());

        await subscription.cancel();
      });
    });

    // ========================================
    // 3. AddToCart Tests
    // ========================================
    group('AddToCartIntent -', () {
      blocTest<CartCubit, CartState>(
        'should emit [CartState(getCartResponse: ...)] when successful',
        build: () {
          when(
            mockAddToCartUseCase.call(requestEntity: anyNamed('requestEntity')),
          ).thenAnswer(
            (_) async => BaseResponse.success(tGetCartResponseEntity),
          );
          return cubit;
        },
        act: (cubit) => cubit.doIntent(
          AddToCartIntent(requestEntity: tAddToCartRequestEntity),
        ),
        expect: () => [
          isA<CartState>().having(
            (state) => state.getCartResponse,
            'getCartResponse',
            tGetCartResponseEntity,
          ),
        ],
        verify: (_) {
          verify(
            mockAddToCartUseCase.call(requestEntity: tAddToCartRequestEntity),
          ).called(1);
        },
      );

      test(
        'should emit AddingToCart then Error UI events on failure',
        () async {
          when(
            mockAddToCartUseCase.call(requestEntity: anyNamed('requestEntity')),
          ).thenAnswer((_) async => BaseResponse.failure(tErrorHandler));
          final uiEvents = <CartEventUI>[];
          final subscription = cubit.uiEvents.listen(uiEvents.add);

          await cubit.doIntent(
            AddToCartIntent(requestEntity: tAddToCartRequestEntity),
          );
          await Future.delayed(Duration.zero);
          expect(uiEvents.length, 2);
          expect(uiEvents[0], isA<AddingToCart>());
          expect(uiEvents[1], isA<Error>());

          await subscription.cancel();
        },
      );

      test('should emit AddingToCart when success', () async {
        when(
          mockAddToCartUseCase.call(requestEntity: anyNamed('requestEntity')),
        ).thenAnswer((_) async => BaseResponse.success(tGetCartResponseEntity));
        final uiEvents = <CartEventUI>[];
        final subscription = cubit.uiEvents.listen(uiEvents.add);
        await cubit.doIntent(
          AddToCartIntent(requestEntity: tAddToCartRequestEntity),
        );

        await Future.delayed(Duration.zero);

        expect(uiEvents.length, 1);
        expect(uiEvents[0], isA<AddingToCart>());
        await subscription.cancel();
      });
    });

    // ========================================
    // 4. UpdateItemQuantity Tests
    // ========================================
    group('UpdateItemQuantityIntent -', () {
      blocTest<CartCubit, CartState>(
        'should emit [CartState(getCartResponse: ...)] when successful',
        build: () {
          when(
            mockUpdateItemQuantityUseCase.call(
              productId: anyNamed('productId'),
              requestEntity: anyNamed('requestEntity'),
            ),
          ).thenAnswer(
            (_) async => BaseResponse.success(tGetCartResponseEntity),
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
            (state) => state.getCartResponse,
            'getCartResponse',
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

      test(
        'should emit Error UI events on failure (No loading emitted in current impl for Update)',
        () async {
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
          expect(uiEvents[0], isA<Error>());

          // Cleanup
          await subscription.cancel();
        },
      );
    });

    // ========================================
    // 5. RemoveItemFromCart Tests
    // ========================================
    group('RemoveItemFromCartIntent -', () {
      blocTest<CartCubit, CartState>(
        'should emit [CartState(getCartResponse: ...)] when successful',
        build: () {
          when(
            mockRemoveItemFromCartUseCase.call(
              productId: anyNamed('productId'),
            ),
          ).thenAnswer(
            (_) async => BaseResponse.success(tGetCartResponseEntity),
          );
          return cubit;
        },
        act: (cubit) =>
            cubit.doIntent(RemoveItemFromCartIntent(productId: 'prod123')),
        expect: () => [
          isA<CartState>().having(
            (state) => state.getCartResponse,
            'getCartResponse',
            tGetCartResponseEntity,
          ),
        ],
        verify: (_) {
          verify(
            mockRemoveItemFromCartUseCase.call(productId: 'prod123'),
          ).called(1);
        },
      );

      test(
        'should emit Error UI events on failure (No loading emitted in current impl for Remove)',
        () async {
          when(
            mockRemoveItemFromCartUseCase.call(
              productId: anyNamed('productId'),
            ),
          ).thenAnswer((_) async => BaseResponse.failure(tErrorHandler));

          final uiEvents = <CartEventUI>[];
          final subscription = cubit.uiEvents.listen(uiEvents.add);

          await cubit.doIntent(RemoveItemFromCartIntent(productId: 'prod123'));
          await Future.delayed(Duration.zero);

          expect(uiEvents.length, 1);
          expect(uiEvents[0], isA<Error>());

          await subscription.cancel();
        },
      );
    });

    // ========================================
    // 6. ClearCart Tests
    // ========================================
    group('ClearCartIntent -', () {
      blocTest<CartCubit, CartState>(
        'should emit [CartState(getCartResponse: null)] when successful',
        build: () {
          when(mockClearCartUseCase.call()).thenAnswer(
            (_) async => BaseResponse.success(tClearCartResponseEntity),
          );
          return cubit;
        },
        act: (cubit) => cubit.doIntent(ClearCartIntent()),
        expect: () => [
          isA<CartState>().having(
            (state) => state.getCartResponse,
            'getCartResponse',
            null,
          ),
        ],
        verify: (_) {
          verify(mockClearCartUseCase.call()).called(1);
        },
      );

      test(
        'should emit LoadingCart then SuccessClearCart UI events on success',
        () async {
          when(mockClearCartUseCase.call()).thenAnswer(
            (_) async => BaseResponse.success(tClearCartResponseEntity),
          );
          final uiEvents = <CartEventUI>[];
          final subscription = cubit.uiEvents.listen(uiEvents.add);

          await cubit.doIntent(ClearCartIntent());

          await Future.delayed(Duration.zero);

          expect(uiEvents.length, 2);
          expect(uiEvents[0], isA<LoadingCart>());
          expect(uiEvents[1], isA<SuccessClearCart>());
          expect((uiEvents[1] as SuccessClearCart).message, 'Cart Cleared');
          await subscription.cancel();
        },
      );

      test('should emit LoadingCart then Error UI events on failure', () async {
        when(
          mockClearCartUseCase.call(),
        ).thenAnswer((_) async => BaseResponse.failure(tErrorHandler));
        final uiEvents = <CartEventUI>[];
        final subscription = cubit.uiEvents.listen(uiEvents.add);

        await cubit.doIntent(ClearCartIntent());

        await Future.delayed(Duration.zero);

        expect(uiEvents.length, 2);
        expect(uiEvents[0], isA<LoadingCart>());
        expect(uiEvents[1], isA<Error>());

        await subscription.cancel();
      });
    });
  });
}
