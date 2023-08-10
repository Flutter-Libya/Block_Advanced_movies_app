import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final String airDate;
  final int seasonNumber;
  final int episodeCount;

  const Season({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.airDate,
    required this.seasonNumber,
    required this.episodeCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        airDate,
        seasonNumber,
        episodeCount,
      ];
}
