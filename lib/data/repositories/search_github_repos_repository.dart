import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/data/models/search_repositories_query_parameters.dart';
import 'package:github_search/data/models/search_repositories_response.dart';

abstract class SearchGithubReposRepository {
  Future<Either<Failure, SearchRepositoriesResponse>> searchRepositories(
      SearchRepositoriesQueryParams queryParams);
}
