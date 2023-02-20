import 'package:flutter/material.dart';
import 'package:github_search/core/errors/failure.dart';
import 'package:github_search/resourses/strings.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbarError(
        BuildContext context, Failure failure) =>
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(failure.message ?? AppStrings.unknownError)));
