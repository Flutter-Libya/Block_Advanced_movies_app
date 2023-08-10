import 'package:equatable/equatable.dart';

class SearchResultItem extends Equatable {
  final int id;
  final String posterUrl;
  final String title;
  final bool isMovie;

  const SearchResultItem({
    required this.id,
    required this.posterUrl,
    required this.title,
    required this.isMovie,
  });

  @override
  List<Object> get props => [
        id,
        posterUrl,
        title,
        isMovie,
      ];
}
