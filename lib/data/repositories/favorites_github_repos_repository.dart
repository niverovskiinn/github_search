import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/data/models/github_repository/github_repository.dart';

abstract class FavoritesGithubReposRepository {
  FutureOr<Either<Failure, void>> addRepo(GithubRepositoryModel item);
  FutureOr<Either<Failure, void>> deleteRepo(GithubRepositoryModel item);
  FutureOr<Either<Failure, List<GithubRepositoryModel>>> getAll();
  FutureOr<Either<Failure, Stream<List<GithubRepositoryModel>>>> getAllStream();
  FutureOr<Either<Failure, GithubRepositoryModel?>> getById(int id);
}
