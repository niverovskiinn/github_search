import 'package:json_annotation/json_annotation.dart';

part 'search_repositories_query_parameters.g.dart';

@JsonSerializable()
class SearchRepositoriesQueryParams {
  @JsonKey(name: 'q')
  final String query;
  final int page;
  @JsonKey(name: 'per_page')
  final int perPage;
  SearchRepositoriesQueryParams({
    this.perPage = 30,
    this.page = 1,
    required this.query,
  });

  factory SearchRepositoriesQueryParams.fromJson(Map<String, Object?> json) =>
      _$SearchRepositoriesQueryParamsFromJson(json);

  Map<String, Object?> toJson() => _$SearchRepositoriesQueryParamsToJson(this);
}
