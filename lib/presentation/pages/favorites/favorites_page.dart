import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/core/base_cubit/base_cubit.dart';
import 'package:github_search/presentation/pages/favorites/cubit/favorites_cubit.dart';
import 'package:github_search/presentation/pages/favorites/widgets/favorite_repository_item.dart';
import 'package:github_search/presentation/widgets/errors.dart';
import 'package:github_search/resourses/strings.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final FavoritesCubit _cubit;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read();
    });
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.favorites)),
      body: BlocConsumer<FavoritesCubit, BaseState>(
        listener: (context, state) {
          if (state is FavoritesError) {
            showSnackbarError(context, state.failure);
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FavoritesInitial) {
            if (state.items.isEmpty) {
              return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    AppStrings.youHaveNtAddedReposToFavYet,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ));
            }
            return ListView.builder(
              itemBuilder: (context, i) {
                final item = state.items[i];
                return FavoriteRepositoryItem(
                  key: ValueKey(item.id),
                  item: item,
                  onDeleteFromFavorite: () => _cubit.deleterFromFavorite(item),
                  onTap: () => _cubit.openUrl(item.htmlUrl),
                );
              },
              itemCount: state.items.length,
            );
          }
          if (state is FailureState) {
            return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.error,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    if (state.failure.message != null)
                      Text(
                        state.failure.message!,
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.center,
                      ),
                  ],
                ));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
