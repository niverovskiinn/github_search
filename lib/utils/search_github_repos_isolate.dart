import 'dart:async';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:github_search/core/errors/dio_isolate_failure.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/data/models/search_repositories_query_parameters.dart';
import 'package:github_search/data/models/search_repositories_response.dart';
import 'package:github_search/data/network/base/dio_init.dart';
import 'package:github_search/data/network/git_repos_api.dart';
import 'package:github_search/data/repositories/impl/search_github_repos_repository_impl.dart';
import 'package:github_search/resourses/strings.dart';
import 'package:github_search/utils/errors_handler.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchGithubReposIsolate {
  late final ReceivePort _rPort;
  late final SendPort _sPort;

  late final Isolate _isolate;

  late Completer<dynamic> _completer;

  StreamSubscription? _streamSubscription;

  SearchGithubReposIsolate._();

  @factoryMethod
  static Future<SearchGithubReposIsolate> spawn() async {
    final dioIsolate = SearchGithubReposIsolate._();
    dioIsolate._rPort = ReceivePort();
    final sendPort = dioIsolate._rPort.sendPort;
    dioIsolate._listenForMessages();
    dioIsolate._isolate = await Isolate.spawn(
      _isolateFunction,
      sendPort,
      onError: sendPort,
      onExit: sendPort,
    );

    return dioIsolate;
  }

  void dispose() {
    _isolate.kill(priority: Isolate.immediate);
    _streamSubscription?.cancel();
  }

  void _listenForMessages() {
    _streamSubscription = _rPort.listen((message) {
      if (message is SendPort) {
        _sPort = message;
        _isolate.pause(_isolate.pauseCapability);
      } else if (message != null) {
        _completer.complete(message);
      }
    });
  }

  Future<Either<Failure, SearchRepositoriesResponse>> searchRepositories(
      String query, int page, int perPage) async {
    await Future.sync(() => null);
    if (_isolate.pauseCapability != null) {
      _isolate.resume(_isolate.pauseCapability!);
    }

    _completer = Completer();
    final props = SearchRepositoriesQueryParams(
      page: page,
      perPage: perPage,
      query: query,
    ).toJson();
    _sPort.send(props);
    final res = await _completer.future;

    _isolate.pause(_isolate.pauseCapability);

    if (res is Either<Failure, SearchRepositoriesResponse>) {
      return res;
    }
    return const Left(DioIsolateFailure(AppStrings.unknownIsolateError));
  }
}

void _isolateFunction(SendPort sendPort) async {
  final rPort = ReceivePort();
  sendPort.send(rPort.sendPort);

  final errorHandler = ErrorHandler();
  final repo = SearchGithubReposRepositoryImpl(
      GitReposApi(_DioModule().dio), ErrorHandler());

  await for (final message in rPort) {
    try {
      final l = await repo
          .searchRepositories(SearchRepositoriesQueryParams.fromJson(message));
      sendPort.send(l);
    } on DioError catch (e) {
      sendPort.send(
          Left<Failure, SearchRepositoriesResponse>(errorHandler.handle(e)));
    } catch (e) {
      sendPort.send(
          Left<Failure, SearchRepositoriesResponse>(errorHandler.handle(e)));
    }
  }
}

class _DioModule extends DioModule {}
