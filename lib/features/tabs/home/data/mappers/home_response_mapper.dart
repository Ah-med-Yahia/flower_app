import 'package:flower_app/core/shared/data/mappers/product_mapper.dart';
import 'package:flower_app/features/tabs/home/data/mappers/category_mapper.dart';
import 'package:flower_app/features/tabs/home/data/mappers/occasion_mapper.dart';
import 'package:flower_app/features/tabs/home/data/models/home_response_dto.dart';
import 'package:flower_app/features/tabs/home/domain/entities/home_response_entity.dart';

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
