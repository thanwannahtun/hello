import 'dart:js_interop';

import 'package:hello/core/resources/data_state.dart';
import 'package:hello/data/database/crud_table.dart';
import 'package:hello/data/models/article.dart';
import 'package:hello/domain/entities/articl_entity.dart';
import 'package:hello/domain/repository/article_repo.dart';

class ArticleRepoImpl implements ArticleRepo {
  final crudTable = CRUDTable.instance;

  @override
  Future<List<ArticleEntity>> getAllArticle() async {
    List<Map<String, dynamic>> articleMap = await crudTable.readData('article');
    List<ArticleEntity> articles = [];
    for (var article in articleMap) {
      articles.add(ArticleModel.fromJson(article));
    }
    return articles;
  }
}
