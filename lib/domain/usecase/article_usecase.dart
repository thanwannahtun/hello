import 'package:dio/dio.dart';
import 'package:hello/core/resources/data_state.dart';
import 'package:hello/core/usecases/usecase.dart';
import 'package:hello/domain/entities/articl_entity.dart';
import 'package:hello/domain/repository/article_repo.dart';

class ArticleUsecase extends Usecase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepo articleRepo;
  ArticleUsecase(this.articleRepo); // ArticleRepoImpl (1)
  @override
  Future<DataState<List<ArticleEntity>>> call({void parem}) async {
    try {
      List<ArticleEntity> articles = await articleRepo.getAllArticle();
      return DataSuccess(articles);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
