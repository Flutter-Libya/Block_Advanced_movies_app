import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/use_case/base_use_case.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';
import 'package:movies_app/search/domain/repository/search_repository.dart';

class SearchUseCase extends BaseUseCase<List<SearchResultItem>, String> {
  final SearchRepository baseSearchRepository;

  SearchUseCase({required this.baseSearchRepository});

  @override
  Future<Either<Failure, List<SearchResultItem>>> call(
      String parameters) async {
    return await baseSearchRepository.search(parameters);
  }
}
