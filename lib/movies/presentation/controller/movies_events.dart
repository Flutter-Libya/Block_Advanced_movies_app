import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object?> get props => [];
}

class GetNowPlayingMoviesEvent extends MoviesEvent {}

class GetUpcomingMoviesEvent extends MoviesEvent {}

class GetPopularMoviesEvent extends MoviesEvent {}

class GetTopRatedMoviesEvent extends MoviesEvent {}

class GetMoviesDetailsEvent extends MoviesEvent {}

class FetchMoreTopRatedMoviesEvent extends MoviesEvent {}

class FetchMorePopularMoviesEvent extends MoviesEvent {}

class GetMoviesEvent extends MoviesEvent {}
