import 'package:equatable/equatable.dart';
import 'package:github_search/data/models/github_repository/github_repository.dart';
import 'package:github_search/data/models/github_repository/github_repository_api_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_repositories_response.g.dart';

@JsonSerializable()
class SearchRepositoriesResponse with EquatableMixin {
  @JsonKey(name: 'total_count')
  final int totalCount;
  @GithubRepositoryApiConverter()
  final List<GithubRepositoryModel> items;

  SearchRepositoriesResponse({
    required this.totalCount,
    required this.items,
  });

  factory SearchRepositoriesResponse.fromJson(Map<String, Object?> json) =>
      _$SearchRepositoriesResponseFromJson(json);

  @override
  List<Object?> get props => [totalCount, items];

  @override
  bool? get stringify => true;
}
