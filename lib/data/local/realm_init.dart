import 'package:github_search/data/models/github_repository/github_repository_from_realm.dart';
import 'package:injectable/injectable.dart';
import 'package:realm/realm.dart';

@module
abstract class RealmModule {
  @singleton
  Realm get realmInstance {
    final config = Configuration.local([GithubRepositoryModelFromRealm.schema]);
    return Realm(config);
  }
}
