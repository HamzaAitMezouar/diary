import 'package:diary/core/exports.dart';
import 'package:diary/data/datasource/aricles/article_model.dart';
import 'package:diary/presentation/home/controller/home_provider.dart';
import 'package:diary/presentation/home/controller/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final homeState = ref.watch(homeProvider);
    if (homeState is HomeLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    if (homeState is HomeLoaded) {
      List<ArticleModel> articles = homeState.articles;
      return ListView.builder(itemBuilder: (context, index) {
        ArticleModel article = homeState.articles[index];
        return ArticleCard(article: article);
      });
    }
    return SizedBox();
  }
}

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.article,
  });

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: D.xxxxxl,
      color: Colors.red,
    );
  }
}
