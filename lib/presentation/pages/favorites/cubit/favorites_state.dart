part of 'favorites_cubit.dart';

class FavoritesInitial extends BaseState {
  final List<GithubRepository> items;

  const FavoritesInitial(this.items);

  @override
  List<Object?> get props => [items];
}

class FavoritesError extends FavoritesInitial {
  final Failure failure;

  const FavoritesError(this.failure, super.items);

  @override
  List<Object?> get props => [items, failure, DateTime.now()];
}
