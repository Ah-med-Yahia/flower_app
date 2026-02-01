import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int? totalPrice;

  const CartEntity({this.totalPrice});

  @override
  List<Object?> get props => [totalPrice];
}
