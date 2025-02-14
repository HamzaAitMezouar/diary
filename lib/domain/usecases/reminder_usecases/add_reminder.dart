import 'package:dartz/dartz.dart';

import 'package:diary/core/errors/errors.dart';

import '../../entities/reminder_entity.dart';
import '../../repositories/reminder_repository/reminder_repository.dart';

class AddReminderUseCase {
  final ReminderRepository repository;

  AddReminderUseCase(this.repository);

  Future<Either<Failure, bool>> call(ReminderEntity reminder) async {
    return repository.addReminder(reminder);
  }
}
