import 'package:json_annotation/json_annotation.dart';

import 'github_repository.dart';

part 'github_repository_from_api.g.dart';

@JsonSerializable()
class GithubRepositoryModelFromAPI implements GithubRepositoryModel {
  @override
  final int id;
  @override
  @JsonKey(name: 'full_name')
  final String name;
  @override
  @JsonKey(name: 'html_url')
  final String htmlUrl;

  GithubRepositoryModelFromAPI({
    required this.id,
    required this.name,
    required this.htmlUrl,
  });

  factory GithubRepositoryModelFromAPI.fromJson(Map<String, Object?> json) =>
      _$GithubRepositoryModelFromAPIFromJson(json);

  Map<String, dynamic> toJson() => _$GithubRepositoryModelFromAPIToJson(this);

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
