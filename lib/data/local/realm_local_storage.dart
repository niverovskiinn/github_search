import 'package:injectable/injectable.dart';
import 'package:realm/realm.dart';

@singleton
class RealmLocalStorage {
  final Realm realm;

  RealmLocalStorage(this.realm);
  T add<T extends RealmObject>(T item) => realm.write(() => realm.add(item));

  void delete<T extends RealmObject>(T item) =>
      realm.write(() => realm.delete(item));

  List<T> getAll<T extends RealmObject>() {
    final repos = realm.all<T>();
    return repos.toList();
  }

  Stream<List<T>> allStream<T extends RealmObject>() {
    final repos = realm.all<T>();
    return repos.changes.map((c) => c.results.toList());
  }

  T? getById<T extends RealmObject>({Object? id}) {
    final repos = realm.query<T>(r'id == $0', [id]);
    return repos.isEmpty ? null : repos.first;
  }
}
