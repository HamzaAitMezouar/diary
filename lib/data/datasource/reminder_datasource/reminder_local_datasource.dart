import 'package:diary/data/models/reminder_model.dart';
import 'package:hive/hive.dart';

abstract class ReminderLocalDataSource {
  Future<List<ReminderModel>> getPendingReminders();
  Future<void> addReminder(ReminderModel reminder);
  Future<void> markReminderAsCompleted(String reminderId);
}

class ReminderLocalDataSourceImpl extends ReminderLocalDataSource {
  final Box<ReminderModel> reminderBox;

  ReminderLocalDataSourceImpl({required this.reminderBox});

  /// 1️⃣ Add a new reminder to Hive
  @override
  Future<void> addReminder(ReminderModel reminder) async {
    await reminderBox.put(reminder.id, reminder);
  }

  @override
  Future<List<ReminderModel>> getPendingReminders() async {
    return reminderBox.values.where((r) => !r.isCompleted).toList();
  }

  @override
  Future<void> markReminderAsCompleted(String reminderId) async {
    final reminder = reminderBox.get(reminderId);
    if (reminder != null) {
      reminderBox.put(reminderId, reminder.copyWith(isCompleted: true));
    }
  }
}
