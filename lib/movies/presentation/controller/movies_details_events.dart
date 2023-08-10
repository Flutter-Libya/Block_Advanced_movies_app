import 'package:equatable/equatable.dart';

abstract class MoviesDetailsEvent extends Equatable {
  const MoviesDetailsEvent();
}

class GetMoviesDetailsEvent extends MoviesDetailsEvent {
  final int movieID;

  const GetMoviesDetailsEvent(this.movieID);

  @override
  List<Object?> get props => [movieID];
}

class GetMoviesRecommendationEvent extends MoviesDetailsEvent {
  final int id;

  const GetMoviesRecommendationEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetMoviesSimilarEvent extends MoviesDetailsEvent {
  final int id;

  const GetMoviesSimilarEvent(this.id);

  @override
  List<Object> get props => [id];
}
