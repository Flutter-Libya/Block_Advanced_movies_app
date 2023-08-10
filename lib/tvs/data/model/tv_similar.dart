import 'package:movies_app/tvs/domain/entities/tv_similar.dart';

class TvsSimilarModel extends TvsSimilar {
  const TvsSimilarModel(
      {required super.overview,
      required super.id,
      required super.name,
      required super.voteAverage,
      required super.genreIds,
      super.backdropPath,
      required super.firstDate,
      super.posterPath,
      required super.adult});

  factory TvsSimilarModel.fromJson(Map<String, dynamic> json) {
    return TvsSimilarModel(
      overview: json["overview"],
      id: json["id"],
      name: json["name"],
      voteAverage: json["vote_average"].toDouble(),
      genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
      backdropPath: json["backdrop_path"] ?? '',
      firstDate: json["first_air_date"],
      posterPath: json["poster_path"] ?? '',
      adult: json['adult'],
    );
  }
}
