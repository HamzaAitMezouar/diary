import 'package:diary/data/datasource/aricles/articel.dart';
import 'package:diary/data/datasource/aricles/article_model.dart';
import 'package:diary/presentation/home/controller/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articlesDataSource = Provider<ArticlesData>((ref) {
  return ArticlesData();
});

class HomeNotifier extends StateNotifier<HomeState> {
  final Ref ref;
  HomeNotifier({
    required this.ref,
  }) : super(HomeInitial()) {
    // Set an initial loading state
    _initialize(); // Call the async method
  }

  _initialize() async {
    state = HomeLoading();
    try {
      List<ArticleModel> articles = await ref.watch(articlesDataSource)();
      state = HomeLoaded(articles: articles);
    } catch (e) {
      state = HomeError(message: e.toString());
    }
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) => HomeNotifier(ref: ref));
