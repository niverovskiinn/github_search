import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/data/models/search_repositories_query_parameters.dart';
import 'package:github_search/data/repositories/search_github_repos_repository.dart';
import 'package:github_search/domain/entities/github_repositories_list.dart';
import 'package:github_search/domain/use_cases/search_repositories/search_repositories_use_case.dart';

// @Singleton(as: SearchRepositoriesUseCase)
class SearchRepositoriesUseCaseDefaultImpl
    implements SearchRepositoriesUseCase {
  final SearchGithubReposRepository _repository;

  SearchRepositoriesUseCaseDefaultImpl(this._repository);

  @override
  FutureOr<Either<Failure, GithubRepositoriesList>> searchRepositories(
      String query, int page, int perPage) async {
    final either =
        await _repository.searchRepositories(SearchRepositoriesQueryParams(
      page: page,
      perPage: perPage,
      query: query,
    ));

    return either
        .map((response) => GithubRepositoriesList.fromResponse(response));
  }

  @override
  void dispose() {}
}
