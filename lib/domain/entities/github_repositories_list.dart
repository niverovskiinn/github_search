import 'package:equatable/equatable.dart';
import 'package:github_search/data/models/search_repositories_response.dart';
import 'package:github_search/domain/entities/github_repository.dart';

class GithubRepositoriesList with EquatableMixin {
  final int totalCount;
  final List<GithubRepository> items;
  const GithubRepositoriesList({
    required this.totalCount,
    required this.items,
  });

  factory GithubRepositoriesList.fromResponse(
          SearchRepositoriesResponse response) =>
      GithubRepositoriesList(
        totalCount: response.totalCount,
        items: response.items
            .map((model) => GithubRepository.fromModel(model))
            .toList(),
      );

  @override
  List<Object?> get props => [totalCount, items];
}
