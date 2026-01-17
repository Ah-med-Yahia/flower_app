import 'package:equatable/equatable.dart';

class ForgetPasswordEntity extends Equatable {
  const ForgetPasswordEntity({required this.message, required this.info});

  final String message;
  final String info;

  @override
  List<Object?> get props => [message, info];
}
