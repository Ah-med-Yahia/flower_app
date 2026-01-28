import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:flower_app/features/cart/data/models/cart_model/cart_item_model.dart';
import 'package:flower_app/features/cart/data/models/cart_model/cart_model.dart';
import 'package:flower_app/features/cart/data/models/clear_cart_response_model.dart';
import 'package:flower_app/features/cart/data/models/get_cart_response_model/get_cart_response_model.dart';
import 'package:flower_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:flower_app/features/cart/domain/entities/add_to_cart_request_entity.dart';
import 'package:flower_app/features/cart/domain/entities/clear_cart_response_entity.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_response_entity.dart';
import 'package:flower_app/features/cart/domain/entities/update_item_quantity_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_repository_impl_test.mocks.dart';

@GenerateMocks([CartRemoteDataSource])

late CartRepositoryImpl cartRepository;
late MockCartRemoteDataSource mockRemoteDataSource;

final tCartProductModel = CartProductModel(
  id: 'p1', title: 'Rose', slug: 'rose', description: 'Red rose',
  imgCover: 'img.jpg', images: ['img1.jpg'], price: 100, priceAfterDiscount: 90,
  quantity: 10, category: 'flowers', occasion: 'love', createdAt: DateTime.now(),
  updatedAt: DateTime.now(), v: 1, isSuperAdmin: false, sold: 5,
  rateAvg: 4, rateCount: 10, productId: 'prod123',
);

final tCartItemModel = CartItemModel(
  product: tCartProductModel, price: 90, quantity: 2, id: 'item1',
);

final tCartModel = CartModel(
  id: 'cart1', user: 'user1', cartItems: [tCartItemModel],
  appliedCoupons: const [], totalPrice: 180, createdAt: DateTime.now(),
  updatedAt: DateTime.now(), v: 1,
);

final tGetCartResponseModel = GetCartResponseModel(
  message: 'Success', numOfCartItems: 1, cart: tCartModel,
);

final tClearCartResponseModel = ClearCartResponseModel(message: 'Cart Cleared');

const tAddToCartRequestEntity = AddToCartRequestEntity(productId: 'prod123', quantity: 2);
const tUpdateItemQuantityRequestEntity = UpdateItemQuantityRequestEntity(quantity: 5);

void verifyOnlyThisCall(Function verification, dynamic mockObject) {
  verification();
  verifyNoMoreInteractions(mockObject);
}

void main() {
  setUpTests();
  getCartTests();
  addToCartTests();
  clearCartTests();
  removeItemFromCartTests();
  updateItemQuantityTests();
}

void setUpTests() {
  setUpAll(() {
    mockRemoteDataSource = MockCartRemoteDataSource();
    cartRepository = CartRepositoryImpl(mockRemoteDataSource);
  });

  setUp(() => reset(mockRemoteDataSource));
}

void getCartTests() {
  group('getCart', () {
    test('should return success response when remote data source is successful', () async {
      when(mockRemoteDataSource.getCart()).thenAnswer((_) async => tGetCartResponseModel);
      final result = await cartRepository.getCart();
      expect(result, isA<BaseResponse<GetCartResponseEntity>>());
      verifyOnlyThisCall(() => verify(mockRemoteDataSource.getCart()).called(1), mockRemoteDataSource);
    });

    test('should return failure response when remote data source throws exception', () async {
      when(mockRemoteDataSource.getCart()).thenThrow(Exception('API Error'));
      final result = await cartRepository.getCart();
      expect(result, isA<BaseResponse<GetCartResponseEntity>>());
      verifyOnlyThisCall(() => verify(mockRemoteDataSource.getCart()).called(1), mockRemoteDataSource);
    });
  });
}

void addToCartTests() {
  group('addToCart', () {
    test('should return success response when remote data source is successful', () async {
      when(mockRemoteDataSource.addToCart(requestModel: anyNamed('requestModel')))
          .thenAnswer((_) async => tGetCartResponseModel);
      final result = await cartRepository.addToCart(requestEntity: tAddToCartRequestEntity);
      expect(result, isA<BaseResponse<GetCartResponseEntity>>());
      verifyOnlyThisCall(() => verify(mockRemoteDataSource.addToCart(requestModel: anyNamed('requestModel'))).called(1), mockRemoteDataSource);
    });
  });
}

void clearCartTests() {
  group('clearCart', () {
    test('should return success response when remote data source is successful', () async {
      when(mockRemoteDataSource.clearCart()).thenAnswer((_) async => tClearCartResponseModel);
      final result = await cartRepository.clearCart();
      expect(result, isA<BaseResponse<ClearCartResponseEntity>>());
      verifyOnlyThisCall(() => verify(mockRemoteDataSource.clearCart()).called(1), mockRemoteDataSource);
    });
  });
}

void removeItemFromCartTests() {
  group('removeItemFromCart', () {
    test('should return success response when remote data source is successful', () async {
      when(mockRemoteDataSource.removeItemFromCart(productId: anyNamed('productId')))
          .thenAnswer((_) async => tGetCartResponseModel);
      final result = await cartRepository.removeItemFromCart(productId: 'prod123');
      expect(result, isA<BaseResponse<GetCartResponseEntity>>());
      verifyOnlyThisCall(() => verify(mockRemoteDataSource.removeItemFromCart(productId: anyNamed('productId'))).called(1), mockRemoteDataSource);
    });
  });
}

void updateItemQuantityTests() {
  group('updateItemQuantity', () {
    test('should return success response when remote data source is successful', () async {
      when(mockRemoteDataSource.updateItemQuantity(
        productId: anyNamed('productId'), requestModel: anyNamed('requestModel'),
      )).thenAnswer((_) async => tGetCartResponseModel);
      final result = await cartRepository.updateItemQuantity(
        productId: 'prod123', requestEntity: tUpdateItemQuantityRequestEntity,
      );
      expect(result, isA<BaseResponse<GetCartResponseEntity>>());
      verifyOnlyThisCall(() => verify(mockRemoteDataSource.updateItemQuantity(
        productId: anyNamed('productId'), requestModel: anyNamed('requestModel'),
      )).called(1), mockRemoteDataSource);
    });
  });
}