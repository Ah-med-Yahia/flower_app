import 'package:flower_app/features/home/domain/entities/category_entity.dart';
import 'package:flower_app/features/home/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

class HomeResponseEntity {
  final String message;
  final List<CategoryEntity> categories;
  final List<ProductEntity> bestSeller;
  final List<OccasionEntity> occasions;

  HomeResponseEntity({
    required this.message,
    required this.categories,
    required this.bestSeller,
    required this.occasions,
  });
}
