part of 'filter_bloc.dart';

sealed class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

final class FilterChangedEvent extends FilterEvent {
  final String query;
  const FilterChangedEvent({required this.query});

  @override
  List<Object> get props => [query];
}
