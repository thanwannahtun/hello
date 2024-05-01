import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hello/core/resources/data_state.dart';
import 'package:hello/data/models/article.dart';
import 'package:hello/data/repository/article_repo_imp.dart';
import 'package:hello/domain/entities/articl_entity.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  late ArticleRepoImpl articleRepo = ArticleRepoImpl();
  ArticleBloc({required this.articleRepo}) : super(ArticleInitial()) {
    on<GetAllArticleEvent>(_getAllArticles);
  }

  FutureOr<void> _getAllArticles(
      GetAllArticleEvent event, Emitter<ArticleState> emit) async {
    List<ArticleEntity> articles = await articleRepo.getAllArticle();
  }
}
