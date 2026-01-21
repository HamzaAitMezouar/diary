import 'package:dartz/dartz.dart';

import '../../../core/errors/errors.dart';
import '../../entities/order_entity.dart';
import '../../repositories/orders/orders_repositoy.dart';

class AcceptPharmacyOrderUsecase {
  final OrdersRepository repository;

  AcceptPharmacyOrderUsecase(this.repository);

  Future<Either<Failure, OrderEntity>> call(int orderId, int pharmacyId) {
    return repository.acceptPharmacyOrder(orderId, pharmacyId);
  }
}
