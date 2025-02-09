import 'dart:convert';

import 'package:diary/data/datasource/aricles/article_model.dart';
import 'package:dio/dio.dart';

class ArticlesData {
  Future<List<ArticleModel>> call() async {
    List<ArticleModel> articles = [];
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://newsapi.org/v2/everything?q=tesla&from=2025-01-09&sortBy=publishedAt&apiKey=2d1c1b32f5784a2d93e50f8e7b769706',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        for (var article in response.data["articles"]) {
          articles.add(ArticleModel.fromJson(article));
        }
      }
      return articles;
    } catch (e) {
      return articles;
    }
  }
}
