import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/tvs/domain/entities/tvs.dart';
import 'package:movies_app/tvs/domain/repository/base_tvs_repository.dart';

class GetOnTheAirTvsUseCase extends BaseUseCase<List<Tvs>, NoParameters> {
  final BaseTvRepository baseTvRepository;

  GetOnTheAirTvsUseCase({required this.baseTvRepository});

  @override
  Future<Either<Failure, List<Tvs>>> call(NoParameters parameters) async {
    return await baseTvRepository.getOnTheAirTv();
  }
}
