import 'package:movies_app/search/domain/entities/search_result_item.dart';

class SearchResultItemModel extends SearchResultItem {
  const SearchResultItemModel({
    required super.id,
    required super.posterUrl,
    required super.title,
    required super.isMovie,
  });

  factory SearchResultItemModel.fromJson(Map<String, dynamic> json) {
    return SearchResultItemModel(
      id: json["id"],
      posterUrl: json["poster_path"] ?? '',
      title: json["title"] ?? json["name"],
      isMovie: json["media_type"] == "movie",
    );
  }
}
