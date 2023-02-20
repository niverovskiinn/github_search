import 'package:github_search/core/base_cubit/base_cubit.dart';
import 'package:github_search/utils/service_locator.dart';

class SplashCubit extends BaseCubit {
  SplashCubit() : super(const LoadingState());

  Future<void> loadResourses() async {
    await serviceLocator.allReady();
    emit(const SuccessState());
  }
}
