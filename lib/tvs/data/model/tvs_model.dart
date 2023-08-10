import 'package:movies_app/tvs/domain/entities/tvs.dart';

class TvModel extends Tvs {
  const TvModel({
    required super.overview,
    required super.id,
    required super.name,
    required super.voteAverage,
    required super.genreIds,
    required super.backdropPath,
    required super.firstAirDate,
    required super.posterPath,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) {
    return TvModel(
      overview: json["overview"],
      id: json["id"],
      name: json["name"],
      voteAverage: json["vote_average"].toDouble(),
      genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
      backdropPath: json["backdrop_path"] ?? '',
      firstAirDate: json["first_air_date"],
      posterPath: json["poster_path"] ?? '',
    );
  }
}
