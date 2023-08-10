import 'package:equatable/equatable.dart';
import 'package:movies_app/tvs/domain/entities/genres.dart';
import 'package:movies_app/tvs/domain/entities/season.dart';

class TvDetails extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final double voteAverage;
  final String firstDate;
  final String lastDate;
  final List<dynamic> runtime;
  final List<Genres> genres;
  final List<Season> season;
  final bool adult;
  final int numberOfSeason;
  final String trailerUrl;

  const TvDetails({
    required this.overview,
    required this.id,
    required this.name,
    required this.voteAverage,
    required this.genres,
    required this.backdropPath,
    required this.firstDate,
    required this.lastDate,
    required this.posterPath,
    required this.adult,
    required this.runtime,
    required this.numberOfSeason,
    required this.season,
    required this.trailerUrl,
  });

  @override
  List<Object> get props => [
        id,
        name,
        backdropPath,
        overview,
        genres,
        posterPath,
        adult,
        firstDate,
        lastDate,
        runtime,
        numberOfSeason,
        season,
        trailerUrl,
      ];
}
