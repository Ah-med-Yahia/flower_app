import 'package:flower_app/features/cart/data/mappers/add_to_cart_request_mapper.dart';
import 'package:flower_app/features/cart/data/mappers/cart_mapper.dart';
import 'package:flower_app/features/cart/data/mappers/get_cart_response_mapper.dart';
import 'package:flower_app/features/cart/data/mappers/update_item_quantity_request_mapper.dart';
import 'package:flower_app/features/cart/data/models/add_to_cart_request_model.dart';
import 'package:flower_app/features/cart/data/models/cart_model/cart_item_model.dart';
import 'package:flower_app/features/cart/data/models/cart_model/cart_model.dart';
import 'package:flower_app/features/cart/data/models/get_cart_response_model/get_cart_response_model.dart';
import 'package:flower_app/features/cart/data/models/update_item_quantity_request_model.dart';
import 'package:flower_app/features/cart/domain/entities/add_to_cart_request_entity.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_entity.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_product_entity.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_response_entity.dart';
import 'package:flower_app/features/cart/domain/entities/update_item_quantity_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

CartProductModel createTestProductModel() {
  return CartProductModel(
    id: 'p1', title: 'Rose', slug: 'rose', description: 'Red rose',
    imgCover: 'img.jpg', images: ['img1.jpg'], price: 100, priceAfterDiscount: 90,
    quantity: 10, category: 'flowers', occasion: 'love', createdAt: DateTime.now(),
    updatedAt: DateTime.now(), v: 1, isSuperAdmin: false, sold: 5,
    rateAvg: 4, rateCount: 10, productId: 'prod123',
  );
}

CartItemModel createTestItemModel() {
  return CartItemModel(
    product: createTestProductModel(), price: 90, quantity: 2, id: 'item1',
  );
}

CartModel createTestCartModel() {
  return CartModel(
    id: 'cart1', user: 'user1', cartItems: [createTestItemModel()],
    appliedCoupons: const [], totalPrice: 180, createdAt: DateTime.now(),
    updatedAt: DateTime.now(), v: 1,
  );
}

void main() {
  group('Cart Mappers', () {
    testAddToCartRequestMapper();
    testUpdateItemQuantityRequestMapper();
    testCartProductModelMapper();
    testCartItemModelMapper();
    testCartModelMapper();
    testGetCartResponseMapper();
  });
}

void testAddToCartRequestMapper() {
  test('AddToCartRequestMapper maps Entity to Model', () {
    const entity = AddToCartRequestEntity(productId: '123', quantity: 2);
    final model = entity.toModel();
    expect(model, isA<AddToCartRequestModel>());
    expect(model.productId, entity.productId);
    expect(model.quantity, entity.quantity);
  });
}

void testUpdateItemQuantityRequestMapper() {
  test('UpdateItemQuantityRequestMapper maps Entity to Model', () {
    const entity = UpdateItemQuantityRequestEntity(quantity: 5);
    final model = entity.toModel();
    expect(model, isA<UpdateItemQuantityRequestModel>());
    expect(model.quantity, entity.quantity);
  });
}


void testCartProductModelMapper() {
  test('CartProductModelMapper maps Model to Entity', () {
    final model = createTestProductModel();
    final entity = model.toEntity();
    expect(entity, isA<CartProductEntity>());
    expect(entity.title, model.title);
    expect(entity.price, model.price);
  });
}

void testCartItemModelMapper() {
  test('CartItemModelMapper maps Model to Entity', () {
    final model = createTestItemModel();
    final entity = model.toEntity();
    expect(entity, isA<CartItemEntity>());
    expect(entity.quantity, model.quantity);
    expect(entity.product, isA<CartProductEntity>());
  });
}

void testCartModelMapper() {
  test('CartModelMapper maps Model to Entity', () {
    final model = createTestCartModel();
    final entity = model.toEntity();
    expect(entity, isA<CartEntity>());
    expect(entity.cartItems.length, 1);
    expect(entity.cartItems.first, isA<CartItemEntity>());
  });
}

void testGetCartResponseMapper() {
  test('GetCartResponseMapper maps Model to Entity', () {
    final model = GetCartResponseModel(
      message: 'Success', numOfCartItems: 1, cart: createTestCartModel(),
    );
    final entity = model.toEntity();
    expect(entity, isA<GetCartResponseEntity>());
    expect(entity.message, model.message);
    expect(entity.cart, isA<CartEntity>());
  });
}