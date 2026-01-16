import 'package:flower_app/features/product_details/domain/models/product_model.dart';

class ProductResponseModel {
  final String message;
  final ProductModel product;

  ProductResponseModel({required this.message, required this.product});
}
