import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/navigation/page_route_names.dart';
import 'package:github_search/presentation/pages/favorites/cubit/favorites_cubit.dart';
import 'package:github_search/presentation/pages/favorites/favorites_page.dart';
import 'package:github_search/presentation/pages/home/cubit/home_cubit.dart';
import 'package:github_search/presentation/pages/home/home_page.dart';
import 'package:github_search/presentation/pages/splash/cubit/splash_cubit.dart';
import 'package:github_search/presentation/pages/splash/splash_page.dart';
import 'package:github_search/presentation/notifiers/favorites_notifier.dart';
import 'package:github_search/utils/service_locator.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

@singleton
class AppRouter {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: PageRoutePathes.splashPage,
        builder: (context, state) => BlocProvider(
          create: (context) => SplashCubit(),
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        path: PageRoutePathes.homePage,
        builder: (context, state) => MultiProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeCubit(
                serviceLocator.get(),
                serviceLocator.get(),
              ),
            ),
            ChangeNotifierProvider(
                create: (_) => FavoritesNotifier(serviceLocator.get()))
          ],
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: PageRoutePathes.favoritesPage,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              FavoritesCubit(serviceLocator.get(), serviceLocator.get()),
          child: const FavoritesPage(),
        ),
      ),
    ],
  );

  GoRouter get router => _router;
}
