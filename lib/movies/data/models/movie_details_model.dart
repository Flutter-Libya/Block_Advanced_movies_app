import 'package:movies_app/core/utils/function.dart';
import 'package:movies_app/movies/data/models/cast_model.dart';
import 'package:movies_app/movies/data/models/genres_model.dart';
import 'package:movies_app/movies/data/models/review_model.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel({
    required super.overview,
    required super.id,
    required super.title,
    required super.voteAverage,
    required super.backdropPath,
    required super.releaseDate,
    required super.posterPath,
    required super.adult,
    required super.genres,
    required super.runtime,
    required super.trailerUrl,
    required super.cast,
    required super.reviews,
  });

  factory MovieDetailsModel.fromMediaDetails(MovieDetails movieDetails) {
    return MovieDetailsModel(
      id: movieDetails.id,
      title: movieDetails.title,
      posterPath: movieDetails.posterPath,
      backdropPath: movieDetails.backdropPath,
      voteAverage: movieDetails.voteAverage,
      releaseDate: movieDetails.releaseDate,
      overview: movieDetails.overview,
      adult: movieDetails.adult,
      genres: movieDetails.genres,
      runtime: movieDetails.runtime,
      trailerUrl: movieDetails.trailerUrl,
      cast: movieDetails.cast,
      reviews: movieDetails.reviews,
    );
  }

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      overview: json["overview"],
      id: json["id"],
      title: json["title"],
      voteAverage: json["vote_average"].toDouble(),
      backdropPath: json["backdrop_path"] ?? '',
      releaseDate: json["release_date"],
      posterPath: json["poster_path"] ?? '',
      adult: json['adult'],
      genres: List<GenresModel>.from(
          json["genres"].map((e) => GenresModel.fromJson(e))),
      runtime: json["runtime"],
      trailerUrl: getTrailerUrl(json),
      cast: List<CastModel>.from(
          (json['credits']['cast'] as List).map((e) => CastModel.fromJson(e))),
      reviews: List<ReviewModel>.from((json['reviews']['results'] as List)
          .map((e) => ReviewModel.fromJson(e))),
    );
  }
}
