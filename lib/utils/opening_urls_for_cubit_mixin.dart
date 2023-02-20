import 'package:github_search/core/base_cubit/base_cubit.dart';
import 'package:github_search/core/errors/url_launching_failure.dart';
import 'package:github_search/resourses/strings.dart';
import 'package:github_search/services/url_launch_service.dart';

mixin OpeningsUrlsForCubitMixin on BaseCubit {
  UrlLaunchService get urlLaunchService;

  Future<void> openUrl(String uri) async {
    final url = Uri.tryParse(uri);
    if (url != null) {
      final failure = await urlLaunchService.launchUrl(url);
      if (failure != null) {
        emit(FailureState(failure));
      }
    } else {
      emit(const FailureState(UrlLaunchingFailure(AppStrings.badLink)));
    }
  }
}
