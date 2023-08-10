import 'package:equatable/equatable.dart';

class Movies extends Equatable {
  final int id;
  final String title;
  final String overview;
  final double voteAverage;
  final String releaseDate;
  final List<int> genreIds;
  final String backdropPath;
  final String posterPath;
  final bool adult;
  final bool isAdded;

  const Movies({
    required this.overview,
    required this.id,
    required this.title,
    required this.voteAverage,
    required this.genreIds,
    required this.backdropPath,
    required this.releaseDate,
    required this.posterPath,
    required this.adult,
    this.isAdded = false,
  });

  @override
  List<Object> get props => [
        id,
        title,
        backdropPath,
        overview,
        genreIds,
        posterPath,
        adult,
        releaseDate,
        isAdded,
      ];
}
