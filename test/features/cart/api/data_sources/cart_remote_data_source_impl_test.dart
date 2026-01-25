import 'package:flower_app/features/cart/api/data_sources/cart_remote_data_source_impl.dart';
import 'package:flower_app/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:flower_app/features/cart/data/models/add_to_cart_request_model.dart';
import 'package:flower_app/features/cart/data/models/cart_model/cart_item_model.dart';
import 'package:flower_app/features/cart/data/models/cart_model/cart_model.dart';
import 'package:flower_app/features/cart/data/models/clear_cart_response_model.dart';
import 'package:flower_app/features/cart/data/models/get_cart_response_model/get_cart_response_model.dart';
import 'package:flower_app/features/cart/data/models/update_item_quantity_request_model.dart';
import 'package:test/test.dart';
import 'package:flower_app/features/cart/api/api_clients/cart_api_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CartApiClient])

late CartRemoteDataSource cartRemoteDataSource;
late MockCartApiClient mockCartApiClient;

const tProductId = '1';
const tQuantity = 2;

final tAddToCartRequestModel = AddToCartRequestModel(
  productId: tProductId,
  quantity: tQuantity,
);

final tUpdateItemQuantityRequestModel = UpdateItemQuantityRequestModel(
  quantity: tQuantity,
);

final tGetCartResponseModel = GetCartResponseModel(
  message: 'Cart fetched successfully',
  numOfCartItems: 1,
  cart: CartModel(
    id: '1',
    user: '1',
    cartItems: [
      CartItemModel(
        id: '1',
        product: CartProductModel(
          id: '1',
          title: 'Product 1',
          slug: 'product-1',
          description: 'Description 1',
          price: 100,
          images: ['image-1'],
          imgCover: 'image-1',
          category: '1',
          isSuperAdmin: true,
          occasion: 'occasion',
          priceAfterDiscount: 100,
          quantity: 10,
          productId: tProductId,
          rateAvg: 2,
          rateCount: 2,
          v: tQuantity,
          sold: 100,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
        price: 100,
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    appliedCoupons: const [],
    totalPrice: 20,
    v: 2,
  ),
);

final tClearCartResponseModel = ClearCartResponseModel(
  message: 'Cart cleared successfully',
);

void verifyOnlyThisCall(Function verification, dynamic mockObject) {
  verification();
  verifyNoMoreInteractions(mockObject);
}

void main() {
  setUpTests();
  getCartTests();
  addToCartTests();
  updateItemQuantityTests();
  removeItemTests();
  clearCartTests();
}

void setUpTests() {
  setUpAll(() {
    mockCartApiClient = MockCartApiClient();
    cartRemoteDataSource = CartRemoteDataSourceImpl(mockCartApiClient);
  });

  setUp(() => reset(mockCartApiClient));
}

void getCartTests() {
  group('getCart', () {
    test('should return GetCartResponseModel when successful', () async {
      when(mockCartApiClient.getCart()).thenAnswer((_) async => tGetCartResponseModel);
      final result = await cartRemoteDataSource.getCart();
      expect(result, tGetCartResponseModel);
      verifyOnlyThisCall(() => verify(mockCartApiClient.getCart()).called(1), mockCartApiClient);
    });

    test('should throw exception when call fails', () async {
      when(mockCartApiClient.getCart()).thenThrow(Exception('API call failed'));
      expect(() => cartRemoteDataSource.getCart(), throwsException);
      verifyOnlyThisCall(() => verify(mockCartApiClient.getCart()).called(1), mockCartApiClient);
    });
  });
}

void addToCartTests() {
  group('addToCart', () {
    test('should return GetCartResponseModel when successful', () async {
      when(mockCartApiClient.addToCart(body: tAddToCartRequestModel))
          .thenAnswer((_) async => tGetCartResponseModel);
      final result = await cartRemoteDataSource.addToCart(requestModel: tAddToCartRequestModel);
      expect(result, tGetCartResponseModel);
      verifyOnlyThisCall(() => verify(mockCartApiClient.addToCart(body: tAddToCartRequestModel)).called(1), mockCartApiClient);
    });

    test('should throw exception when call fails', () async {
      when(mockCartApiClient.addToCart(body: tAddToCartRequestModel))
          .thenThrow(Exception('API call failed'));
      expect(() => cartRemoteDataSource.addToCart(requestModel: tAddToCartRequestModel), throwsException);
      verifyOnlyThisCall(() => verify(mockCartApiClient.addToCart(body: tAddToCartRequestModel)).called(1), mockCartApiClient);
    });
  });
}

void updateItemQuantityTests() {
  group('updateItemQuantity', () {
    test('should return GetCartResponseModel when successful', () async {
      when(mockCartApiClient.updateItemQuantity(productId: tProductId, body: tUpdateItemQuantityRequestModel))
          .thenAnswer((_) async => tGetCartResponseModel);
      final result = await cartRemoteDataSource.updateItemQuantity(productId: tProductId, requestModel: tUpdateItemQuantityRequestModel);
      expect(result, tGetCartResponseModel);
      verifyOnlyThisCall(() => verify(mockCartApiClient.updateItemQuantity(productId: tProductId, body: tUpdateItemQuantityRequestModel)).called(1), mockCartApiClient);
    });

    test('should throw exception when call fails', () async {
      when(mockCartApiClient.updateItemQuantity(productId: tProductId, body: tUpdateItemQuantityRequestModel))
          .thenThrow(Exception('API call failed'));
      expect(() => cartRemoteDataSource.updateItemQuantity(productId: tProductId, requestModel: tUpdateItemQuantityRequestModel), throwsException);
      verifyOnlyThisCall(() => verify(mockCartApiClient.updateItemQuantity(productId: tProductId, body: tUpdateItemQuantityRequestModel)).called(1), mockCartApiClient);
    });
  });
}

void removeItemTests() {
  group('removeItem', () {
    test('should return GetCartResponseModel when successful', () async {
      when(mockCartApiClient.removeItemFromCart(productId: tProductId))
          .thenAnswer((_) async => tGetCartResponseModel);
      final result = await cartRemoteDataSource.removeItemFromCart(productId: tProductId);
      expect(result, tGetCartResponseModel);
      verifyOnlyThisCall(() => verify(mockCartApiClient.removeItemFromCart(productId: tProductId)).called(1), mockCartApiClient);
    });

    test('should throw exception when call fails', () async {
      when(mockCartApiClient.removeItemFromCart(productId: tProductId))
          .thenThrow(Exception('API call failed'));
      expect(() => cartRemoteDataSource.removeItemFromCart(productId: tProductId), throwsException);
      verifyOnlyThisCall(() => verify(mockCartApiClient.removeItemFromCart(productId: tProductId)).called(1), mockCartApiClient);
    });
  });
}

void clearCartTests() {
  group('clearCart', () {
    test('should return ClearCartResponseModel when successful', () async {
      when(mockCartApiClient.clearCart()).thenAnswer((_) async => tClearCartResponseModel);
      final result = await cartRemoteDataSource.clearCart();
      expect(result, tClearCartResponseModel);
      verifyOnlyThisCall(() => verify(mockCartApiClient.clearCart()).called(1), mockCartApiClient);
    });

    test('should throw exception when call fails', () async {
      when(mockCartApiClient.clearCart()).thenThrow(Exception('API call failed'));
      expect(() => cartRemoteDataSource.clearCart(), throwsException);
      verifyOnlyThisCall(() => verify(mockCartApiClient.clearCart()).called(1), mockCartApiClient);
    });
  });
}