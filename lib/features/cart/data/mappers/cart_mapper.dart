import 'package:flower_app/features/cart/data/models/cart_model/cart_item_model.dart';
import 'package:flower_app/features/cart/data/models/cart_model/cart_model.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_entity.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_product_entity.dart';

extension CartModelMapper on CartModel {
  CartEntity toEntity() {
    return CartEntity(
      id: id,
      user: user,
      cartItems: cartItems.map((e) => e.toEntity()).toList(),
      appliedCoupons: appliedCoupons,
      totalPrice: totalPrice,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension CartItemModelMapper on CartItemModel {
  CartItemEntity toEntity() {
    return CartItemEntity(
      product: product.toEntity(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}

extension CartProductModelMapper on CartProductModel {
  CartProductEntity toEntity() {
    return CartProductEntity(
      id: id,
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
      createdAt: createdAt,
      updatedAt: updatedAt,
      isSuperAdmin: isSuperAdmin,
      sold: sold,
      rateAvg: rateAvg,
      rateCount: rateCount,
      productId: productId,
    );
  }
}
