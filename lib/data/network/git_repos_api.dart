import 'package:dio/dio.dart';
import 'package:github_search/data/models/search_repositories_response.dart';
import 'package:github_search/data/network/base/base_api.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'git_repos_api.g.dart';

@RestApi()
@singleton
abstract class GitReposApi extends BaseApi {
  @factoryMethod
  factory GitReposApi(Dio dio) = _GitReposApi;

  @GET('/search/repositories')
  Future<SearchRepositoriesResponse> searchRepositories(
      @Queries() Map<String, dynamic> query);
}
