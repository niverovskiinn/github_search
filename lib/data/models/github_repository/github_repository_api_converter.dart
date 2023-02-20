import 'package:github_search/core/errors/inappropriate_type_failure.dart';
import 'package:json_annotation/json_annotation.dart';

import 'github_repository.dart';
import 'github_repository_from_api.dart';

class GithubRepositoryApiConverter
    implements JsonConverter<GithubRepositoryModel, Map<String, dynamic>> {
  const GithubRepositoryApiConverter();

  @override
  GithubRepositoryModel fromJson(Map<String, dynamic> json) =>
      GithubRepositoryModelFromAPI.fromJson(json);

  @override
  Map<String, dynamic> toJson(GithubRepositoryModel object) {
    if (object is GithubRepositoryModelFromAPI) {
      return object.toJson();
    } else {
      throw const InappropriateTypeFailure(
          'Type have to be GithubRepositoryFromAPI');
    }
  }
}
