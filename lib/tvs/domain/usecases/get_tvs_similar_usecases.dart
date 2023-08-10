import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/use_case/base_use_case.dart';
import 'package:movies_app/tvs/domain/entities/tv_similar.dart';
import 'package:movies_app/tvs/domain/repository/base_tvs_repository.dart';

class GetTvSimilarUseCase
    extends BaseUseCase<List<TvsSimilar>, TvSimilarParameters> {
  final BaseTvRepository baseTvRepository;

  GetTvSimilarUseCase({required this.baseTvRepository});

  @override
  Future<Either<Failure, List<TvsSimilar>>> call(
      TvSimilarParameters parameters) async {
    return await baseTvRepository.getTvSimilar(parameters);
  }
}

class TvSimilarParameters extends Equatable {
  final int tvID;

  const TvSimilarParameters({required this.tvID});

  @override
  List<Object> get props => [tvID];
}
