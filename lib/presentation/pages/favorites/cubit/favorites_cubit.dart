import 'dart:async';

import 'package:github_search/core/base_cubit/base_cubit.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/domain/entities/github_repository.dart';
import 'package:github_search/domain/use_cases/favorite_repositories/favorite_repositories_use_case.dart';
import 'package:github_search/services/url_launch_service.dart';
import 'package:github_search/utils/opening_urls_for_cubit_mixin.dart';

part 'favorites_state.dart';

class FavoritesCubit extends BaseCubit with OpeningsUrlsForCubitMixin {
  final FavoriteRepositoriesUseCase _favoriteUseCase;
  @override
  final UrlLaunchService urlLaunchService;

  StreamSubscription? _streamSubscription;

  FavoritesCubit(this._favoriteUseCase, this.urlLaunchService) {
    emit(const LoadingState());
    _initFavoritesRepos();
  }

  Future<void> _initFavoritesRepos() async {
    final favEither = await _favoriteUseCase.getAllStream();
    favEither.fold(
      (err) => emit(FailureState(err)),
      (stream) => _streamSubscription =
          stream.listen((items) => emit(FavoritesInitial(items))),
    );
  }

  Future<void> deleterFromFavorite(GithubRepository item) async {
    final either = await _favoriteUseCase.deleteRepo(item);
    if (either.isLeft) {
      final currentState = state;
      if (currentState is FavoritesInitial) {
        emit(FavoritesError(either.left, currentState.items));
      }
    }
  }

  void dispose() {
    _streamSubscription?.cancel();
  }
}
