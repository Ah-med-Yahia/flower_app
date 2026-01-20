class ProductEntity {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final double price;
  final double priceAfterDiscount;
  final int? discount;
  final int quantity;
  final String category;
  final String occasion;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool isSuperAdmin;
  final int? sold;
  final double rateAvg;
  final int rateCount;

  ProductEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    this.discount,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isSuperAdmin,
    this.sold,
    required this.rateAvg,
    required this.rateCount,
  });
}
