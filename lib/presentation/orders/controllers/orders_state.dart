import 'package:diary/domain/entities/location_entity.dart';
import 'package:diary/domain/entities/order_entity.dart';

abstract class OrdersState {
  final List<OrderEntity> orders;
  OrdersState(this.orders);
}

class InitOrdersState extends OrdersState {
  InitOrdersState(super.orders);
}

class OrdersLoadedState extends OrdersState {
  OrdersLoadedState(super.orders);
}

class OrdersLoadingState extends OrdersState {
  OrdersLoadingState(super.orders);
}

class OrdersAddingErrorState extends OrdersState {
  final String error;

  OrdersAddingErrorState(super.orders, this.error);
}

class OrdersLoadingErrorState extends OrdersState {
  final String error;
  OrdersLoadingErrorState(super.orders, this.error);
}

class OrdersAddedSuccessState extends OrdersState {
  OrdersAddedSuccessState(super.orders);
}
