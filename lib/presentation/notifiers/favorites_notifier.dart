import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_search/domain/entities/github_repository.dart';
import 'package:github_search/domain/use_cases/favorite_repositories/favorite_repositories_use_case.dart';

class FavoritesNotifier extends ValueNotifier<List<GithubRepository>> {
  final FavoriteRepositoriesUseCase _favoriteUseCase;
  FavoritesNotifier(this._favoriteUseCase) : super([]) {
    _initFavoritesRepos();
  }
  StreamSubscription? _streamSubscription;

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
  }

  Future<void> _initFavoritesRepos() async {
    final favEither = await _favoriteUseCase.getAllStream();
    if (favEither.isRight) {
      _streamSubscription = favEither.right.listen((items) => value = items);
    }
  }

  void changeFavoriteValue(GithubRepository item, bool val) {
    if (value.contains(item) != val) {
      if (val) {
        _favoriteUseCase.addRepo(item);
      } else {
        _favoriteUseCase.deleteRepo(item);
      }
    }
  }
}
