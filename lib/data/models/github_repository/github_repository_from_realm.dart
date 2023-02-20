import 'package:realm/realm.dart';

import 'github_repository.dart';

part 'github_repository_from_realm.g.dart';

@RealmModel()
class _GithubRepositoryModelFromRealm implements GithubRepositoryModel {
  @PrimaryKey()
  @override
  late int id;
  @override
  late String htmlUrl;
  @override
  late String name;

  @override
  List<Object?> get props => [id, name, htmlUrl];

  @override
  bool? get stringify => true;
}
