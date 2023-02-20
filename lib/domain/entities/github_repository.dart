import 'package:equatable/equatable.dart';
import 'package:github_search/data/models/github_repository/github_repository.dart';
import 'package:github_search/data/models/github_repository/github_repository_from_api.dart';
import 'package:github_search/data/models/github_repository/github_repository_from_realm.dart';

class GithubRepository with EquatableMixin {
  final int id;
  final String name;
  final String htmlUrl;
  const GithubRepository({
    required this.id,
    required this.name,
    required this.htmlUrl,
  });

  factory GithubRepository.fromModel(GithubRepositoryModel model) =>
      GithubRepository(
        id: model.id,
        name: model.name,
        htmlUrl: model.htmlUrl,
      );

  GithubRepositoryModel toModel<T extends GithubRepositoryModel>() {
    if (T == GithubRepositoryModelFromAPI) {
      return GithubRepositoryModelFromAPI(id: id, htmlUrl: htmlUrl, name: name);
    } else if (T == GithubRepositoryModelFromRealm) {
      return GithubRepositoryModelFromRealm(id, htmlUrl, name);
    }
    throw UnimplementedError();
  }

  GithubRepository copyWithUpdatingFavorites(bool favorites) =>
      GithubRepository(id: id, name: name, htmlUrl: htmlUrl);

  @override
  List<Object?> get props => [id, name, htmlUrl];
}
