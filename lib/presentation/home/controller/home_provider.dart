import 'package:diary/core/DI/use_cases_provider.dart';
import 'package:diary/presentation/home/controller/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(ref),
);

class HomeNotifier extends StateNotifier<HomeState> {
  Ref ref;
  HomeNotifier(this.ref) : super(const HomeLoading()) {
    loadReminders();
  }

  /// 📌 Load Reminders from Hive
  Future<void> loadReminders() async {
    final res = await ref.read(getRemindersUseCaseProvider)();
    state = res.fold((l) => HomeError(l.errorMessage), (r) => HomeLoaded(r));
  }
}
