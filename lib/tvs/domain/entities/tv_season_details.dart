import 'package:equatable/equatable.dart';
import 'package:movies_app/tvs/domain/entities/genres.dart';

class TvSeasonDetails extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String stillPath;

  final double voteAverage;
  final String airDate;

  final int runtime;
  final List<Genres> genres;

  final int numberOfSeason;
  final int numberOfEpisode;

  const TvSeasonDetails({
    required this.overview,
    required this.id,
    required this.name,
    required this.voteAverage,
    required this.genres,
    required this.stillPath,
    required this.airDate,
    required this.runtime,
    required this.numberOfSeason,
    required this.numberOfEpisode,
  });

  @override
  List<Object> get props => [
        id,
        name,
        stillPath,
        overview,
        genres,
        airDate,
        runtime,
        numberOfSeason,
        numberOfEpisode,
      ];
}
