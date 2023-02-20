import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/data/models/github_repository/github_repository_from_realm.dart';
import 'package:github_search/data/repositories/favorites_github_repos_repository.dart';
import 'package:github_search/domain/entities/github_repository.dart';
import 'package:github_search/domain/use_cases/favorite_repositories/favorite_repositories_use_case.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: FavoriteRepositoriesUseCase)
class FavoriteRepositoriesUseCaseImpl implements FavoriteRepositoriesUseCase {
  final FavoritesGithubReposRepository _repository;

  FavoriteRepositoriesUseCaseImpl(this._repository);

  @override
  FutureOr<Either<Failure, void>> addRepo(GithubRepository item) =>
      _repository.addRepo(item.toModel<GithubRepositoryModelFromRealm>());

  @override
  FutureOr<Either<Failure, void>> deleteRepo(GithubRepository item) =>
      _repository.deleteRepo(item.toModel<GithubRepositoryModelFromRealm>());

  @override
  FutureOr<Either<Failure, List<GithubRepository>>> getAll() async {
    final either = await _repository.getAll();
    return either.map((list) =>
        list.map((model) => GithubRepository.fromModel(model)).toList());
  }

  @override
  FutureOr<Either<Failure, Stream<List<GithubRepository>>>>
      getAllStream() async {
    final either = await _repository.getAllStream();
    return either.map((stream) => stream.map((list) =>
        list.map((model) => GithubRepository.fromModel(model)).toList()));
  }

  @override
  FutureOr<Either<Failure, GithubRepository?>> getById(int id) async {
    final either = await _repository.getById(id);
    return either.map(
        (model) => model != null ? GithubRepository.fromModel(model) : null);
  }
}
