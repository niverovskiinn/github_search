part of 'home_cubit.dart';

class HomeInitialLoading extends InitialState {}

class HomeSearchLoaded extends BaseState {
  final List<GithubRepository> items;

  const HomeSearchLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class HomeLoadingMore extends BaseState {}
