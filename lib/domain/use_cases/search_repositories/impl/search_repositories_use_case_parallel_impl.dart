import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/data/models/search_repositories_response.dart';
import 'package:github_search/utils/search_github_repos_isolate.dart';
import 'package:github_search/domain/entities/github_repositories_list.dart';
import 'package:github_search/domain/entities/github_repository.dart';
import 'package:github_search/domain/use_cases/search_repositories/search_repositories_use_case.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SearchRepositoriesUseCase)
class SearchRepositoriesUseCaseParallelsImpl
    implements SearchRepositoriesUseCase {
  final SearchGithubReposIsolate _isolate1;
  final SearchGithubReposIsolate _isolate2;

  SearchRepositoriesUseCaseParallelsImpl(this._isolate1, this._isolate2);

  @disposeMethod
  @override
  void dispose() {
    _isolate1.dispose();
    _isolate2.dispose();
  }

  @override
  FutureOr<Either<Failure, GithubRepositoriesList>> searchRepositories(
      String query, int page, int perPage) async {
    assert(perPage.isEven,
        'Parameter perPage must be even number. Use SearchRepositoriesUseCaseDefaultImpl for odd numbers.');
    final results =
        await Future.wait<Either<Failure, SearchRepositoriesResponse>>([
      _isolate1.searchRepositories(query, page * 2 - 1, perPage ~/ 2),
      _isolate2.searchRepositories(query, page * 2, perPage ~/ 2),
    ]);
    final errorInd = results.indexWhere((e) => e.isLeft);

    if (errorInd >= 0) {
      return Left(results[errorInd].left);
    } else {
      final resp1 = results[0].right;
      final resp2 = results[1].right;

      resp1.items.addAll(resp2.items);

      return Right(
        GithubRepositoriesList(
          totalCount: resp1.totalCount,
          items: resp1.items
              .map((model) => GithubRepository.fromModel(model))
              .toList(),
        ),
      );
    }
  }
}
