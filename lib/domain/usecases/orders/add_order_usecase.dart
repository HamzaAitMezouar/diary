import 'package:dartz/dartz.dart';
import 'package:diary/core/params/orders_params.dart';
import 'package:diary/domain/entities/order_entity.dart';
import 'package:diary/domain/repositories/orders/orders_repositoy.dart';

import '../../../core/errors/errors.dart';

class AddOrderUseCase {
  final OrdersRepository repository;

  AddOrderUseCase(this.repository);

  Future<Either<Failure, List<OrderEntity>>> call(OrdersParams params) {
    return repository.addOrder(params);
  }
}
