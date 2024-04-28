import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchInitial(querie: '')) {
    on<SearchQueryChangedEvent>(_searchQuery);
  }

  FutureOr<void> _searchQuery(
      SearchQueryChangedEvent event, Emitter<SearchState> emit) {
    final searchLists = [
      'apple',
      'banana',
      'orange',
      'grape',
      'durine',
      'watermelon',
      'melon'
    ];

    List<String> searchResults = [];

    for (var item in searchLists) {
      if (event.query.isNotEmpty) {
        if (item.toLowerCase().contains(event.query)) {
          searchResults.add(item);
        }
      }
    }

    emit(SearchLoadedState(searchResults: searchResults));
  }
}
