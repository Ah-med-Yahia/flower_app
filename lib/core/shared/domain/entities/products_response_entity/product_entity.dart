import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    required String id,
    required String title,
    String? description,
    String? imageCover,
    List<String>? images,
    required double price,
    double? priceAfterDiscount,
    double? discount,
    String? discountPercentage,
    required String categoryId,
    required String occasionId,
    required int quantity,
    @Default(true) bool inStock,
  }) = _ProductEntity;
}
