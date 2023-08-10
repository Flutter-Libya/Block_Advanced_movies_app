import 'package:movies_app/movies/domain/entities/movie_recommendation.dart';

class MoviesRecommendationModel extends MoviesRecommendation {
  const MoviesRecommendationModel(
      {required super.overview,
      required super.id,
      required super.title,
      required super.voteAverage,
      required super.genreIds,
      super.backdropPath,
      required super.releaseDate,
      super.posterPath,
      required super.adult});

  factory MoviesRecommendationModel.fromJson(Map<String, dynamic> json) {
    return MoviesRecommendationModel(
      overview: json["overview"],
      id: json["id"],
      title: json["title"],
      voteAverage: json["vote_average"].toDouble(),
      genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
      backdropPath: json["backdrop_path"] ?? '',
      releaseDate: json["release_date"],
      posterPath: json["poster_path"] ?? '',
      adult: json['adult'],
    );
  }
}
