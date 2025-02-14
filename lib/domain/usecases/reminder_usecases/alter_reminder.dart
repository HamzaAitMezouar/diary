import 'package:dartz/dartz.dart';

import 'package:diary/core/errors/errors.dart';

import '../../repositories/reminder_repository/reminder_repository.dart';

class MarkReminderAsCompletedUseCase {
  final ReminderRepository repository;

  MarkReminderAsCompletedUseCase(this.repository);

  Future<Either<Failure, bool>> call(String id) async {
    return repository.markReminderAsCompleted(id);
  }
}
