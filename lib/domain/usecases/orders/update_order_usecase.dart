import 'package:dartz/dartz.dart';
import 'package:diary/data/models/order_model.dart';
import 'package:diary/domain/entities/order_entity.dart';
import 'package:diary/domain/repositories/orders/orders_repositoy.dart';

import '../../../core/errors/errors.dart';

class UpdateOrdersUseCase {
  final OrdersRepository repository;

  UpdateOrdersUseCase(this.repository);

  Future<Either<Failure, List<OrderEntity>>> call(int orderId, OrderStatus status) {
    return repository.updateOrder(orderId, status);
  }
}
