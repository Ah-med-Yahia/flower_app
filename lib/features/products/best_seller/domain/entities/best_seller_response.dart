import 'package:equatable/equatable.dart';

import 'best_seller.dart';
import 'pagination_meta_data.dart';

class BestSellerResponse extends Equatable {
  final String? message;
  final List<BestSeller>? bestSeller;
  final PaginationMetadata? paginationMetadata;

  const BestSellerResponse({
    this.message,
    this.bestSeller,
    this.paginationMetadata,
  });

  @override
  List<Object?> get props => [message, bestSeller, paginationMetadata];
}
