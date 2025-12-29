class PaginationMetadata {
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
}
