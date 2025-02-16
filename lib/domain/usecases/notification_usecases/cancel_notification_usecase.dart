import 'package:dartz/dartz.dart';

import '../../../core/errors/errors.dart';
import '../../repositories/notifications_repository/notifications_repository.dart';

class CancelNotificationUseCase {
  final NotificationRepository repository;

  CancelNotificationUseCase(this.repository);

  Future<Either<Failure, bool>> call(int id) {
    return repository.cancelNotification(id);
  }
}
