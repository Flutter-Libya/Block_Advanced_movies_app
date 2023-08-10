import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/use_case/base_use_case.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetAllPopularMoviesUseCase extends BaseUseCase<List<Movies>, int> {
  final BaseMovieRepository baseMovieRepository;

  GetAllPopularMoviesUseCase({required this.baseMovieRepository});

  @override
  Future<Either<Failure, List<Movies>>> call(int parameters) async {
    return await baseMovieRepository.getAllPopularMovies(parameters);
  }
}
