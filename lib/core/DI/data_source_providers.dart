import 'package:diary/data/datasource/reminder_datasource/reminder_local_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final reminderLocalDataSource = Provider<ReminderLocalDataSource>((ref) {
  return ReminderLocalDataSourceImpl(
    Hive.box('reminderBox'),
  );
});
