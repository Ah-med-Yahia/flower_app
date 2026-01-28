import 'package:flower_app/features/occasion/domain/entities/occasion_product_entity.dart';

class GetOccasionProductsEntity {
  final OccasionProductEntity? products;

  GetOccasionProductsEntity({required this.products});
  GetOccasionProductsEntity copyWith({OccasionProductEntity? products}) {
    return GetOccasionProductsEntity(products: products ?? this.products);
  }
}
