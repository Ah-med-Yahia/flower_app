import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';

class ProductResponseModel {
  final String message;
  final ProductEntity product;

  ProductResponseModel({required this.message, required this.product});

  ProductResponseModel copyWith({String? message, ProductEntity? product}) {
    return ProductResponseModel(
      message: message ?? this.message,
      product: product ?? this.product,
    );
  }
}
