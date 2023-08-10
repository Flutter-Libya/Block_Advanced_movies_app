import 'package:equatable/equatable.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';

enum SearchRequestStatus { empty, loading, loaded, error, noResults }

class SearchState extends Equatable {
  const SearchState({
    this.searchResults = const [],
    this.status = SearchRequestStatus.empty,
    this.message = '',
  });

  final List<SearchResultItem> searchResults;
  final SearchRequestStatus status;
  final String message;

  SearchState copyWith({
    List<SearchResultItem>? searchResults,
    SearchRequestStatus? status,
    String? message,
  }) {
    return SearchState(
      searchResults: searchResults ?? this.searchResults,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        searchResults,
        status,
        message,
      ];
}
