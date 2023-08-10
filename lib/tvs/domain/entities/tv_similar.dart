import 'package:equatable/equatable.dart';

class TvsSimilar extends Equatable {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final String firstDate;
  final List<int> genreIds;
  final String? backdropPath;
  final String? posterPath;
  final bool adult;

  const TvsSimilar({
    required this.overview,
    required this.id,
    required this.name,
    required this.voteAverage,
    required this.genreIds,
    this.backdropPath,
    required this.firstDate,
    this.posterPath,
    required this.adult,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        backdropPath,
        overview,
        genreIds,
        posterPath,
        adult,
        firstDate,
      ];
}
