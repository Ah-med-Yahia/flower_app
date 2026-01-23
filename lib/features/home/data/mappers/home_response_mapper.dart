import 'package:flower_app/features/home/data/mappers/category_mapper.dart';
import 'package:flower_app/features/home/data/mappers/occasion_mapper.dart';
import 'package:flower_app/features/home/data/mappers/product_dto_mapper.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';

extension HomeResponseMapper on HomeResponseDto {
  HomeResponseEntity toEntity() {
    return HomeResponseEntity(
      message: message,
      categories: categories?.map((dto) => dto.toEntity()).toList(),
      bestSeller: bestSeller?.map((dto) => dto.toEntity()).toList(),
      occasions: occasions?.map((dto) => dto.toEntity()).toList(),
    );
  }
}
