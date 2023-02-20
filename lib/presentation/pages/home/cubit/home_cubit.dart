import 'package:github_search/core/base_cubit/base_cubit.dart';
import 'package:github_search/domain/entities/github_repository.dart';
import 'package:github_search/domain/use_cases/search_repositories/search_repositories_use_case.dart';
import 'package:github_search/services/url_launch_service.dart';
import 'package:github_search/utils/debouncer.dart';
import 'package:github_search/utils/opening_urls_for_cubit_mixin.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit with OpeningsUrlsForCubitMixin {
  static const downloadPerPage = 30;

  int _currentPage = 1;
  int _totalCount = 0;
  int _alreadyLoadedCount = 0;
  String? _searchQuery;

  final SearchRepositoriesUseCase _searchUseCase;
  @override
  final UrlLaunchService urlLaunchService;
  final _debouncer = Debouncer(duration: const Duration(seconds: 1));

  HomeCubit(this._searchUseCase, this.urlLaunchService);

  void searchRepository(String q) {
    _searchQuery = q;

    _debouncer.run(() {
      if (q.trim().isEmpty) {
        emit(const InitialState());
        return;
      }
      emit(HomeInitialLoading());
      _currentPage = 1;
      _totalCount = 0;
      _alreadyLoadedCount = 0;
      _loadPageData();
    });
  }

  Future<void> _loadPageData() async {
    if (_searchQuery != null) {
      final either = await _searchUseCase.searchRepositories(
        _searchQuery!,
        _currentPage,
        HomeCubit.downloadPerPage,
      );

      either.fold(
        (e) => emit(FailureState(e)),
        (list) {
          _totalCount = list.totalCount;
          emit(HomeSearchLoaded(list.items));
          _currentPage++;
        },
      );
    }
  }

  Future<void> loadMoreRepos(int loadedCount) async {
    if (loadedCount < _totalCount &&
        state is! HomeLoadingMore &&
        _alreadyLoadedCount < loadedCount) {
      _alreadyLoadedCount = loadedCount;
      emit(HomeLoadingMore());
      await _loadPageData();
    }
  }
}
