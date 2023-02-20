import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/core/base_cubit/base_cubit.dart';
import 'package:github_search/navigation/page_route_names.dart';
import 'package:github_search/presentation/pages/splash/cubit/splash_cubit.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await context.read<SplashCubit>().loadResourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, BaseState>(
      listener: (context, state) {
        if (state is SuccessState) {
          context.go(PageRoutePathes.homePage);
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
