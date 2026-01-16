import 'package:equatable/equatable.dart';

class PaginationMetadata extends Equatable {
  final int? currentPage;
  final int? numberOfPages;
  final int? limit;
  final int? total;

  const PaginationMetadata({
    this.currentPage,
    this.numberOfPages,
    this.limit,
    this.total,
  });

  @override
  List<Object?> get props => [currentPage, numberOfPages, limit, total];
}
