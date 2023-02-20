import 'package:equatable/equatable.dart';

abstract class GithubRepositoryModel with EquatableMixin {
  final int id;
  final String name;
  final String htmlUrl;

  const GithubRepositoryModel(this.id, this.name, this.htmlUrl);
  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
