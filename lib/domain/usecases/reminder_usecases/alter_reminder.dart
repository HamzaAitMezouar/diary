import 'package:dartz/dartz.dart';

import 'package:diary/core/errors/errors.dart';

import '../../repositories/reminder_repository/reminder_repository.dart';

class MarkReminderAsCompleted {
  final ReminderRepository repository;

  MarkReminderAsCompleted(this.repository);

  Future<Future<Either<Failure, bool>>> call(String id) async {
    return repository.markReminderAsCompleted(id);
  }
}
