import 'package:diary/core/DI/repositories_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/reminder_usecases/add_reminder.dart';
import '../../domain/usecases/reminder_usecases/alter_reminder.dart';
import '../../domain/usecases/reminder_usecases/get_reminder.dart';

final addReminderUseCaseProvider = Provider<AddReminderUseCase>((ref) {
  final repo = ref.watch(reminderRepositoryProvider);
  return AddReminderUseCase(repo);
});

final getRemindersUseCaseProvider = Provider<GetRemindersUseCase>((ref) {
  final repo = ref.watch(reminderRepositoryProvider);
  return GetRemindersUseCase(repo);
});

final markReminderAsCompletedUseCaseProvider = Provider<MarkReminderAsCompletedUseCase>((ref) {
  final repo = ref.watch(reminderRepositoryProvider);
  return MarkReminderAsCompletedUseCase(repo);
});
