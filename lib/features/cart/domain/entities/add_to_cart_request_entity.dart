import 'package:equatable/equatable.dart';

class AddToCartRequestEntity extends Equatable {
  final String productId;
  final int quantity;

  const AddToCartRequestEntity({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productId, quantity];
}
