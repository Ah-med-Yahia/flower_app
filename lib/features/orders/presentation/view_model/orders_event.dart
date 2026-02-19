import 'package:flower_app/features/orders/domain/usecases/get_user_orders_usecase.dart';

sealed class OrdersEvent {}

class GetOrdersEvent extends OrdersEvent {
  final OrderFilter? filter;

  GetOrdersEvent({this.filter});
}
