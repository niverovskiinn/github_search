import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/core/errors/network_failure.dart';
import 'package:github_search/core/errors/realm_failure.dart';
import 'package:github_search/core/errors/unknown_failure.dart';
import 'package:github_search/resourses/strings.dart';
import 'package:injectable/injectable.dart';
import 'package:realm/realm.dart';

@singleton
class ErrorHandler {
  Failure get unknownFailure => const UnknownFailure(AppStrings.unknownError);

  Failure handleDioError(DioError err) {
    return NetworkFailure(err.response?.data['message'] ?? err.message);
  }

  Failure handleRealmError(RealmError e) =>
      RealmFailure(e.message ?? AppStrings.unknownLocalDbError);

  Failure handleRealmException(RealmException e) => RealmFailure(e.message);

  Failure handleDartException(Exception e) {
    var eMessage = e.toString();
    return eMessage.length > "Exception".length
        ? UnknownFailure(eMessage.substring("Exception: ".length))
        : unknownFailure;
  }

  Failure handleDartError(Error e) {
    return unknownFailure;
  }

  Failure handle(e) {
    log("ErrorHandler.handle", error: e);
    if (e is DioError) {
      return handleDioError(e);
    }
    if (e is RealmError) {
      return handleRealmError(e);
    }
    if (e is RealmException) {
      return handleRealmException(e);
    }
    if (e is Exception) {
      return handleDartException(e);
    }
    if (e is Error) {
      return handleDartError(e);
    }
    return unknownFailure;
  }
}
