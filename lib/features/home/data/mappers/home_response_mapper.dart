import '../../domain/entities/home_response_entity.dart';
import '../models/home_response_dto.dart';
import 'category_mapper.dart';
import 'occasion_mapper.dart';
import 'product_dto_mapper.dart';

extension HomeResponseMapper on HomeResponseDto {
  HomeResponseEntity toEntity() {
    return HomeResponseEntity(
      message: message ?? '',
      categories: categories?.map((e) => e.toEntity()).toList() ?? [],
      bestSeller: bestSeller?.map((e) => e.toEntity()).toList() ?? [],
      occasions: occasions?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
