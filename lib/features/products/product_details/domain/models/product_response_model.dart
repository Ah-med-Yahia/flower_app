import 'product_model.dart';

class ProductResponseModel {
  final String message;
  final ProductModel product;

  ProductResponseModel({required this.message, required this.product});
}
