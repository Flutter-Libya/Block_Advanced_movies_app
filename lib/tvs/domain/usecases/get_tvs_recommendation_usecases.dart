import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/use_case/base_use_case.dart';
import 'package:movies_app/tvs/domain/entities/tv_recommendation.dart';
import 'package:movies_app/tvs/domain/repository/base_tvs_repository.dart';

class GetTvRecommendationUseCase
    extends BaseUseCase<List<TvsRecommendation>, TvRecommendationParameters> {
  final BaseTvRepository baseTvRepository;

  GetTvRecommendationUseCase({required this.baseTvRepository});

  @override
  Future<Either<Failure, List<TvsRecommendation>>> call(
      TvRecommendationParameters parameters) async {
    return await baseTvRepository.getTvRecommendation(parameters);
  }
}

class TvRecommendationParameters extends Equatable {
  final int tvID;

  const TvRecommendationParameters({required this.tvID});

  @override
  List<Object> get props => [tvID];
}
