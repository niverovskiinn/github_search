import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:github_search/domain/entities/github_repository.dart';
import 'package:github_search/presentation/notifiers/favorites_notifier.dart';

class SearchRepositoryItem extends StatefulWidget {
  final GithubRepository item;
  final AsyncCallback? onTap;
  final FavoritesNotifier? favoritesNotifier;
  const SearchRepositoryItem({
    Key? key,
    required this.item,
    this.onTap,
    this.favoritesNotifier,
  }) : super(key: key);

  @override
  State<SearchRepositoryItem> createState() => _SearchRepositoryItemState();
}

class _SearchRepositoryItemState extends State<SearchRepositoryItem> {
  var favorites = false;
  FavoritesNotifier? _favoritesNotifier;

  void onChangeFavorites() {
    if (_favoritesNotifier != null) {
      final favoriteItem = _favoritesNotifier!.value.contains(widget.item);
      if (favorites != favoriteItem) {
        setState(() => favorites = favoriteItem);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _favoritesNotifier = widget.favoritesNotifier;
    _favoritesNotifier?.addListener(onChangeFavorites);
    SchedulerBinding.instance.addPostFrameCallback((_) => onChangeFavorites());
  }

  @override
  void dispose() {
    super.dispose();
    _favoritesNotifier?.removeListener(onChangeFavorites);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          favorites ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() => favorites = !favorites);
          _favoritesNotifier?.changeFavoriteValue(widget.item, favorites);
        },
      ),
      title: Text(widget.item.name),
      trailing: const Icon(Icons.link),
      onTap: widget.onTap,
    );
  }
}
