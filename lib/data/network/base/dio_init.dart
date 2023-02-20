import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:github_search/utils/configs.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @singleton
  Dio get dio {
    final dio = Dio(BaseOptions(baseUrl: AppConfigs.apiUrl));
    dio.interceptors.add(PrettyDioLogger(
      canShowLog: true,
      queryParameters: true,
      requestBody: false,
    ));
    dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) => handler.next(options
        ..headers[HttpHeaders.authorizationHeader] =
            'Bearer ${AppConfigs.gitToken}'),
    ));
    return dio;
  }
}
