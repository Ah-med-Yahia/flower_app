import 'package:flower_app/features/categories/data/models/get_all_categories_models/category_model.dart';
import 'package:flower_app/features/categories/data/models/metadata/category_metadata_model.dart';
import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/get_all_categories_list_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_categories_response_model.g.dart';

@JsonSerializable()
class GetAllCategoriesResponseModel {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'metadata')
  final CategoryMetadataModel? metadata;
  @JsonKey(name: 'categories', defaultValue: [])
  final List<CategoryModel>? categories;

  GetAllCategoriesResponseModel({this.message, this.metadata, this.categories});

  factory GetAllCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllCategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCategoriesResponseModelToJson(this);

  GetCategoryListEntity toEntity() {
    return GetCategoryListEntity(
      categories: categories?.map((e) => e.toEntity()).toList(),
    );
  }
}
