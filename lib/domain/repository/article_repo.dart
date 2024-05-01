import 'package:hello/core/resources/data_state.dart';
import 'package:hello/domain/entities/articl_entity.dart';

abstract class ArticleRepo {
  Future<List<ArticleEntity>> getAllArticle();
}
