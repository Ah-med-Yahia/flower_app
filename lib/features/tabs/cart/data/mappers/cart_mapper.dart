import 'package:flower_app/features/tabs/cart/data/models/cart_model/cart_item_model.dart';
import 'package:flower_app/features/tabs/cart/data/models/cart_model/cart_model.dart';
import 'package:flower_app/features/tabs/cart/domain/entities/cart_entity/cart_entity.dart';
import 'package:flower_app/features/tabs/cart/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:flower_app/features/tabs/cart/domain/entities/cart_entity/cart_product_entity.dart';

extension CartModelMapper on CartModel {
  CartEntity toEntity() {
    return CartEntity(
      cartItems: cartItems.map((e) => e.toEntity()).toList(),
      appliedCoupons: appliedCoupons,
      totalPrice: totalPrice,
    );
  }
}

extension CartItemModelMapper on CartItemModel {
  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id,
      product: product.toEntity(),
      price: price,
      quantity: quantity,
    );
  }
}

extension CartProductModelMapper on CartProductModel {
  CartProductEntity toEntity() {
    return CartProductEntity(
      productId: productId,
      title: title,
      slug: slug,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      quantity: quantity,
      category: category,
      occasion: occasion,
    );
  }
}
