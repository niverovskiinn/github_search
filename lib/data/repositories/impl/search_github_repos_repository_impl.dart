import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/data/models/search_repositories_query_parameters.dart';
import 'package:github_search/data/models/search_repositories_response.dart';
import 'package:github_search/data/network/git_repos_api.dart';
import 'package:github_search/data/repositories/search_github_repos_repository.dart';
import 'package:github_search/utils/errors_handler.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SearchGithubReposRepository)
class SearchGithubReposRepositoryImpl implements SearchGithubReposRepository {
  final GitReposApi _api;
  final ErrorHandler _errorHandler;

  SearchGithubReposRepositoryImpl(this._api, this._errorHandler);

  @override
  Future<Either<Failure, SearchRepositoriesResponse>> searchRepositories(
      SearchRepositoriesQueryParams queryParams) async {
    try {
      final resp = await _api.searchRepositories(
        queryParams.toJson(),
      );
      return Right(resp);
    } catch (e) {
      return Left(_errorHandler.handle(e));
    }
  }
}
