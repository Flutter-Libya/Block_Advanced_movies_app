import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/use_case/base_use_case.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';
import 'package:dartz/dartz.dart';

class GetPopularMoviesUseCase extends BaseUseCase<List<Movies>, NoParameters> {
  final BaseMovieRepository baseMovieRepository;

  GetPopularMoviesUseCase({required this.baseMovieRepository});

  @override
  Future<Either<Failure, List<Movies>>> call(NoParameters parameters) async {
    return await baseMovieRepository.getPopularMovies();
  }
}
