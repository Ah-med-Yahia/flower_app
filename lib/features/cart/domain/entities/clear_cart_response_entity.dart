import 'package:equatable/equatable.dart';

class ClearCartResponseEntity extends Equatable {
  final String message;

  const ClearCartResponseEntity({required this.message});

  @override
  List<Object?> get props => [message];
}
