import 'package:diary/core/DI/use_cases_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'categories_state.dart';

final categoryProvider = StateNotifierProvider<HomeNotifier, CategoryState>(
  (ref) => HomeNotifier(ref),
);

class HomeNotifier extends StateNotifier<CategoryState> {
  Ref ref;
  HomeNotifier(this.ref) : super(const CategoryLaoding()) {
    loadCategory();
  }

  Future<void> loadCategory() async {
    final res = await ref.read(getMedicamentsCategoriesUsecasesProvider)();
    state = res.fold((l) => CategoryError(l.errorMessage), (r) => CategoryLoaded(r));
  }
}
