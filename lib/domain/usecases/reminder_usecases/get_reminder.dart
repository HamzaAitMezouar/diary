import 'package:dartz/dartz.dart';

import 'package:diary/core/errors/errors.dart';

import '../../entities/reminder_entity.dart';
import '../../repositories/reminder_repository/reminder_repository.dart';

class GetRemindersUseCase {
  final ReminderRepository repository;

  GetRemindersUseCase(this.repository);

  Future<Either<Failure, List<ReminderEntity>>> call() async {
    return repository.getPendingReminders();
  }
}
