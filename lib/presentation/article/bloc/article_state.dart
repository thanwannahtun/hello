part of 'article_bloc.dart';

sealed class ArticleState extends Equatable {
  const ArticleState();
  
  @override
  List<Object> get props => [];
}

final class ArticleInitial extends ArticleState {}
