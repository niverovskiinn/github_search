import 'package:flutter/material.dart';
import 'package:github_search/resourses/strings.dart';
import 'package:go_router/go_router.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback onOk;
  final VoidCallback? onCancel;
  const ConfirmDeleteDialog({
    Key? key,
    required this.onOk,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.pleaseConfirm),
      content:
          const Text(AppStrings.areYouSureWantRemoveRepositoryFromFavorites),
      actions: [
        TextButton(
            onPressed: () {
              onCancel?.call();
              context.pop();
            },
            child: const Text(AppStrings.cancel)),
        TextButton(
            onPressed: () {
              onOk();
              context.pop();
            },
            child: const Text(
              AppStrings.remove,
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
  }
}
