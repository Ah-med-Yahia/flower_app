import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final T? data;

  const BaseState({this.isLoading = false, this.errorMessage, this.data});

  BaseState<T> copyWith({bool? isLoading, String? errorMessage, T? data}) {
    return BaseState<T>(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, data];
}

class CartBaseState<T> extends Equatable {
  final bool isError;
  final bool isEmpty;
  final T? data;
  const CartBaseState({this.isError = false, this.isEmpty = false, this.data});

  CartBaseState<T> copyWith({bool? isError, bool? isEmpty, T? data}) {
    return CartBaseState<T>(
      isError: isError ?? this.isError,
      isEmpty: isEmpty ?? this.isEmpty,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isError, isEmpty, data];
}
