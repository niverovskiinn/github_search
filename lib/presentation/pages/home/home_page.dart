import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/core/base_cubit/base_cubit.dart';
import 'package:github_search/domain/entities/github_repository.dart';
import 'package:github_search/navigation/page_route_names.dart';
import 'package:github_search/presentation/pages/home/cubit/home_cubit.dart';
import 'package:github_search/presentation/pages/home/widgets/search_repository_item.dart';
import 'package:github_search/presentation/widgets/errors.dart';
import 'package:github_search/presentation/notifiers/favorites_notifier.dart';
import 'package:github_search/resourses/strings.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  late final HomeCubit _cubit;
  final _repos = <GithubRepository>[];
  FavoritesNotifier? _favoritesNotifier;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read();
      _favoritesNotifier = context.read();
      _scrollController.addListener(() {
        if (_scrollController.position.extentAfter < 300) {
          _cubit.loadMoreRepos(_repos.length);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _favoritesNotifier?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
        actions: [
          IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              context.push(PageRoutePathes.favoritesPage);
            },
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, BaseState>(
        listener: (context, state) {
          if (state is FailureState) {
            showSnackbarError(context, state.failure);
          }
        },
        builder: (context, state) {
          if (state is InitialState) {
            _repos.clear();
          } else if (state is HomeSearchLoaded) {
            if (_repos.isEmpty || _repos.last != state.items.last) {
              _repos.addAll(state.items);
            }
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverToBoxAdapter(
                  child: TextField(
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search, color: Colors.black26),
                      hintText: AppStrings.search,
                    ),
                    onChanged: (q) => _cubit.searchRepository(q),
                  ),
                ),
              ),
              if (state is HomeInitialLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final item = _repos[i];
                  return SearchRepositoryItem(
                    item: item,
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      await _cubit.openUrl(item.htmlUrl);
                    },
                    favoritesNotifier: _favoritesNotifier,
                  );
                },
                childCount: _repos.length,
              )),
              if (state is HomeLoadingMore)
                const SliverPadding(
                  padding: EdgeInsets.all(10),
                  sliver: SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
