import 'package:flutter/material.dart';
import 'package:github_search/navigation/app_router.dart';
import 'package:github_search/utils/service_locator.dart';

Future<void> main() async {
  await Future.wait([
    configureDependencies(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routerConfig: serviceLocator.get<AppRouter>().router,
    );
  }
}
