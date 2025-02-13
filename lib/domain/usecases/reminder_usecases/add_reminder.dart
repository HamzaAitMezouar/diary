import 'package:dartz/dartz.dart';

import 'package:diary/core/errors/errors.dart';

import '../../entities/reminder_entity.dart';
import '../../repositories/reminder_repository/reminder_repository.dart';

class AddReminder {
  final ReminderRepository repository;

  AddReminder(this.repository);

  Future<Future<Either<Failure, bool>>> call(ReminderEntity reminder) async {
    return repository.addReminder(reminder);
  }
}
