part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {
  final String querie;
  const SearchInitial({required this.querie});

  @override
  List<Object> get props => [querie];
}

final class SearchLoadedState extends SearchState {
  final List<String> searchResults;
  const SearchLoadedState({required this.searchResults});

  @override
  List<Object> get props => [searchResults];
}
