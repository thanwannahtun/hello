part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class CategoryAddEvent extends CategoryEvent {
  final Category category;
  const CategoryAddEvent(this.category);

  @override
  List<Object> get props => [category];
}

final class CategoryEditEvent extends CategoryEvent {
  final Category category;
  const CategoryEditEvent(this.category);

  @override
  List<Object> get props => [category];
}

final class CategoryDeleteEvent extends CategoryEvent {
  final int categoryId;
  const CategoryDeleteEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
