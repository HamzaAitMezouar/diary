import 'package:dartz/dartz.dart';
import 'package:diary/core/errors/errors.dart';
import 'package:diary/data/datasource/reminder_datasource/reminder_local_datasource.dart';
import 'package:diary/domain/entities/reminder_entity.dart';

import '../../../core/errors/exceptions.dart';

abstract class ReminderRepository {
  Future<Either<Failure, List<ReminderEntity>>> getPendingReminders();
  Future<Either<Failure, bool>> addReminder(ReminderEntity reminder);
  Future<Either<Failure, bool>> markReminderAsCompleted(String reminderId);
}

class ReminderRepositoryImpl extends ReminderRepository {
  ReminderLocalDataSource _dataSource;
  ReminderRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, bool>> addReminder(ReminderEntity reminder) async {
    try {
      final result = await _dataSource.addReminder(reminder.toModel());
      return Right(result);
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, List<ReminderEntity>>> getPendingReminders() async {
    try {
      final result = await _dataSource.getPendingReminders();
      return Right(result.map((e) => e.toEntity()).toList());
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> markReminderAsCompleted(String reminderId) async {
    try {
      final result = await _dataSource.markReminderAsCompleted(reminderId);
      return Right(result);
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }
}
