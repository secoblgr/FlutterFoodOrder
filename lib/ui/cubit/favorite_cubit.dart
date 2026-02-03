import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/fav_repository.dart';

class FavoritesCubit extends Cubit<List<int>> {
  final FavoritesRepository repository;

  FavoritesCubit(this.repository) : super([]);

  Future<void> loadFavorites() async {
    emit(await repository.getFavorites());
  }

  Future<void> toggleFavorite(int id) async {
    repository.toggleFavorite(id);
    emit(await repository.getFavorites());
  }

  /// 🔥 async DEĞİL
  bool isFavorite(int id) {
    return state.contains(id);
  }
}
