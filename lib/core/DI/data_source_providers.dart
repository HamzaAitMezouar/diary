import 'package:diary/core/DI/storage_provider.dart';
import 'package:diary/data/datasource/reminder_datasource/reminder_local_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reminderLocalDataSource = Provider<ReminderLocalDataSource>((ref) {
  final hivebox = ref.watch(hivereminderBoxProvider);
  return ReminderLocalDataSourceImpl(hivebox);
});
