import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/use_case/base_use_case.dart';
import 'package:movies_app/movies/domain/entities/movie_recommendation.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetMovieRecommendationUseCase extends BaseUseCase<
    List<MoviesRecommendation>, MovieRecommendationParameters> {
  final BaseMovieRepository baseMovieRepository;

  GetMovieRecommendationUseCase({required this.baseMovieRepository});

  @override
  Future<Either<Failure, List<MoviesRecommendation>>> call(
      MovieRecommendationParameters parameters) async {
    return await baseMovieRepository.getMovieRecommendation(parameters);
  }
}

class MovieRecommendationParameters extends Equatable {
  final int movieID;

  const MovieRecommendationParameters({required this.movieID});

  @override
  List<Object> get props => [movieID];
}
