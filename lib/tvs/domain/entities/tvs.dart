import 'package:equatable/equatable.dart';

class Tvs extends Equatable {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final String firstAirDate;
  final List<int> genreIds;
  final String backdropPath;
  final String posterPath;

  const Tvs({
    required this.overview,
    required this.id,
    required this.name,
    required this.voteAverage,
    required this.genreIds,
    required this.backdropPath,
    required this.firstAirDate,
    required this.posterPath,
  });

  @override
  List<Object> get props => [
        id,
        name,
        backdropPath,
        overview,
        genreIds,
        posterPath,
        firstAirDate,
      ];
}
