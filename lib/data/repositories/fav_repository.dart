class FavoritesRepository {
  final Set<int> _favoriteIds = {};

  List<int> getFavorites() => _favoriteIds.toList();

  bool isFavorite(int id) => _favoriteIds.contains(id);

  void toggleFavorite(int id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
  }
}
