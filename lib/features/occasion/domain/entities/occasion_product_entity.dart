class OccasionProductEntity {
  final String id;
  final String name;
  final String image;
  final num price;
  final num priceAfterDiscount;

  OccasionProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.priceAfterDiscount,
  });

  int get discountPercentage {
    if (price <= 0 || priceAfterDiscount > price) return 0;

    final percentage = 100 - ((priceAfterDiscount / price) * 100);
    return percentage.round();
  }
}
