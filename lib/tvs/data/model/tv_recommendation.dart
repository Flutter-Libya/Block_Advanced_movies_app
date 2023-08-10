import 'package:movies_app/tvs/domain/entities/tv_recommendation.dart';

class TvsRecommendationModel extends TvsRecommendation {
  const TvsRecommendationModel(
      {required super.overview,
      required super.id,
      required super.name,
      required super.voteAverage,
      required super.genreIds,
      super.backdropPath,
      required super.firstDate,
      super.posterPath,
      required super.adult});

  factory TvsRecommendationModel.fromJson(Map<String, dynamic> json) {
    return TvsRecommendationModel(
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
