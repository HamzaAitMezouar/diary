import 'package:diary/domain/repositories/reminder_repository/reminder_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data_source_providers.dart';

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return ReminderRepositoryImpl(ref.watch(reminderLocalDataSource));
});
