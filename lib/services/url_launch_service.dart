import 'package:flutter/services.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/core/errors/url_launching_failure.dart';
import 'package:github_search/resourses/strings.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

@singleton
class UrlLaunchService {
  Future<Failure?> launchUrl(Uri url) async {
    try {
      final success = await url_launcher.launchUrl(url,
          mode: url_launcher.LaunchMode.externalApplication);
      if (!success) {
        return const UrlLaunchingFailure(AppStrings.failedOpeningLink);
      }
    } on PlatformException catch (e) {
      return UrlLaunchingFailure(e.message ?? AppStrings.failedOpeningLink);
    }
    return null;
  }
}
