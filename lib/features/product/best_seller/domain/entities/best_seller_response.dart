import 'package:flower_app/features/product/best_seller/domain/entities/pagination_meta_data.dart';

import 'best_seller.dart';

class BestSellerResponse {
  final String? message;
  final List<BestSeller>? bestSeller;
  final PaginationMetadata? paginationMetadata;

  const BestSellerResponse({
    this.message,
    this.bestSeller,
    this.paginationMetadata,
  });
}
