import 'package:github_search/core/errors/failure.dart';

class NetworkFailure extends Failure {
  const NetworkFailure([String? message]) : super(message);
}
