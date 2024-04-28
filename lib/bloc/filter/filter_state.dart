part of 'filter_bloc.dart';

sealed class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

final class FilterInitial extends FilterState {}

final class FilterChangeState extends FilterState {
  final List<String> queries;
  const FilterChangeState({required this.queries});

  @override
  List<Object> get props => [queries];
}
