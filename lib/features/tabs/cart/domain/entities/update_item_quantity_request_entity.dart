import 'package:equatable/equatable.dart';

class UpdateItemQuantityRequestEntity extends Equatable {
  final int quantity;

  const UpdateItemQuantityRequestEntity({required this.quantity});

  @override
  List<Object?> get props => [quantity];
}
