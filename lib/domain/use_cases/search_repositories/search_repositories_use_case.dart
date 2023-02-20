import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/domain/entities/github_repositories_list.dart';

abstract class SearchRepositoriesUseCase {
  FutureOr<Either<Failure, GithubRepositoriesList>> searchRepositories(
      String query, int page, int perPage);

  void dispose();
}
