import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:github_search/utils/service_locator.config.dart';

final serviceLocator = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: false,
  asExtension: true,
)
Future<void> configureDependencies() async => serviceLocator.init();
