import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/domain/entities/github_repository.dart';

abstract class FavoriteRepositoriesUseCase {
  FutureOr<Either<Failure, void>> addRepo(GithubRepository item);
  FutureOr<Either<Failure, void>> deleteRepo(GithubRepository item);
  FutureOr<Either<Failure, List<GithubRepository>>> getAll();
  FutureOr<Either<Failure, Stream<List<GithubRepository>>>> getAllStream();
  FutureOr<Either<Failure, GithubRepository?>> getById(int id);
}
