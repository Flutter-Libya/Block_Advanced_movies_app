import 'package:movies_app/core/utils/function.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';

class MovieModel extends Movies {
  const MovieModel(
      {required super.overview,
      required super.id,
      required super.title,
      required super.voteAverage,
      required super.genreIds,
      required super.backdropPath,
      required super.releaseDate,
      required super.posterPath,
      required super.adult});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      overview: json["overview"],
      id: json["id"],
      title: json["title"],
      voteAverage: json["vote_average"].toDouble(),
      genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
      backdropPath: json["backdrop_path"] ?? '',
      releaseDate: getDate(json['release_date']),
      posterPath: json["poster_path"] ?? '',
      adult: json['adult'],
    );
  }
}
