import 'package:diary/core/errors/exceptions.dart';
import 'package:diary/data/models/reminder_model.dart';
import 'package:hive/hive.dart';

abstract class ReminderLocalDataSource {
  Future<List<ReminderModel>> getPendingReminders();
  Future<bool> addReminder(ReminderModel reminder);
  Future<bool> markReminderAsCompleted(String reminderId);
}

class ReminderLocalDataSourceImpl extends ReminderLocalDataSource {
  final Box<ReminderModel> _reminderBox;

  ReminderLocalDataSourceImpl(this._reminderBox);

  @override
  Future<bool> addReminder(ReminderModel reminder) async {
    try {
      await _reminderBox.put(reminder.id, reminder);
      return true;
    } on HiveError catch (e) {
      throw CustomException(message: e.message.toString());
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<List<ReminderModel>> getPendingReminders() async {
    try {
      return _reminderBox.values.where((r) => !r.isCompleted).toList();
    } on HiveError catch (e) {
      throw CustomException(message: e.message.toString());
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<bool> markReminderAsCompleted(String reminderId) async {
    try {
      final reminder = _reminderBox.get(reminderId);
      if (reminder != null) {
        await _reminderBox.put(reminderId, reminder.copyWith(isCompleted: true));
        return true;
      }
      return false;
    } on HiveError catch (e) {
      throw CustomException(message: e.message.toString());
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
