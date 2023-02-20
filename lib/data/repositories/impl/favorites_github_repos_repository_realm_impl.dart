import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/data/local/realm_local_storage.dart';
import 'package:github_search/data/models/github_repository/github_repository.dart';
import 'package:github_search/data/models/github_repository/github_repository_from_realm.dart';
import 'package:github_search/data/repositories/favorites_github_repos_repository.dart';
import 'package:github_search/utils/errors_handler.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: FavoritesGithubReposRepository)
class FavoritesGithubReposRepositoryRealmImpl
    implements FavoritesGithubReposRepository {
  final RealmLocalStorage realm;
  final ErrorHandler _errorHandler;

  FavoritesGithubReposRepositoryRealmImpl(this.realm, this._errorHandler);
  @override
  FutureOr<Either<Failure, void>> addRepo(GithubRepositoryModel item) {
    try {
      realm.add(item is GithubRepositoryModelFromRealm
          ? item
          : GithubRepositoryModelFromRealm(item.id, item.htmlUrl, item.name));
      return const Right(Never);
    } catch (e) {
      return Left(_errorHandler.handle(e));
    }
  }

  @override
  FutureOr<Either<Failure, void>> deleteRepo(GithubRepositoryModel item) {
    try {
      final res = realm.getById<GithubRepositoryModelFromRealm>(id: item.id);
      if (res != null) {
        realm.delete(res);
      }
      return const Right(Never);
    } catch (e) {
      return Left(_errorHandler.handle(e));
    }
  }

  @override
  FutureOr<Either<Failure, List<GithubRepositoryModel>>> getAll() {
    try {
      return Right(realm.getAll<GithubRepositoryModelFromRealm>());
    } catch (e) {
      return Left(_errorHandler.handle(e));
    }
  }

  @override
  FutureOr<Either<Failure, Stream<List<GithubRepositoryModel>>>>
      getAllStream() {
    try {
      return Right(realm.allStream<GithubRepositoryModelFromRealm>());
    } catch (e) {
      return Left(_errorHandler.handle(e));
    }
  }

  @override
  FutureOr<Either<Failure, GithubRepositoryModel?>> getById(int id) {
    try {
      return Right(realm.getById<GithubRepositoryModelFromRealm>(id: id));
    } catch (e) {
      return Left(_errorHandler.handle(e));
    }
  }
}
