part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState(
      {required this.categories, required this.status, this.error});

  final List<Category> categories;
  final String? error;
  final BlocStatus status;

  CategoryState copyWith(
      {List<Category>? categories, String? error, BlocStatus? status}) {
    return CategoryState(
        categories: categories ?? this.categories,
        error: error ?? this.error,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [categories, error, status];

  @override
  String toString() {
    return 'CategoryState{categories=$categories, error=$error, status=$status}';
  }
}
