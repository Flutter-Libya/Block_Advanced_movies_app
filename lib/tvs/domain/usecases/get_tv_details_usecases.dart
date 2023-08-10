import 'package:equatable/equatable.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/tvs/domain/entities/tv_details.dart';
import 'package:movies_app/tvs/domain/repository/base_tvs_repository.dart';

class GetTvsDetailsUseCase
    extends BaseUseCase<TvDetails, TvsDetailsParameters> {
  final BaseTvRepository baseTvsRepository;

  GetTvsDetailsUseCase({required this.baseTvsRepository});

  @override
  Future<Either<Failure, TvDetails>> call(
      TvsDetailsParameters parameters) async {
    return await baseTvsRepository.getTvDetails(parameters);
  }
}

class TvsDetailsParameters extends Equatable {
  final int tvsID;

  const TvsDetailsParameters({required this.tvsID});

  @override
  List<Object> get props => [tvsID];
}
