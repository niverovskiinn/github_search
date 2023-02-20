import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_search/domain/entities/github_repository.dart';
import 'package:github_search/presentation/pages/favorites/widgets/confirm_delete_dialog.dart';

class FavoriteRepositoryItem extends StatelessWidget {
  final GithubRepository item;
  final VoidCallback onDeleteFromFavorite;
  final AsyncCallback? onTap;
  const FavoriteRepositoryItem({
    Key? key,
    required this.item,
    required this.onDeleteFromFavorite,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => showDialog(
          context: context,
          builder: (c) =>
              ConfirmDeleteDialog(onOk: () => onDeleteFromFavorite()),
        ),
      ),
      title: Text(item.name),
      trailing: const Icon(Icons.link),
      onTap: onTap,
    );
  }
}
