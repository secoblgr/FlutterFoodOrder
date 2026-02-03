import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/data/entity/foods.dart';
import 'package:project/data/repositories/food_repository.dart';

class HomeCubit extends Cubit<List<Foods>> {
  HomeCubit() : super(<Foods>[]);

  final FoodRepository repo = FoodRepository();

  List<Foods> _allFoods = [];

  Future<void> getFoods() async {
    final foods = await repo.getFoods();
    _allFoods = foods;
    emit(foods);
  }


  void search(String keyword) {
    if (keyword.isEmpty) {
      // 🔁 input boş → tüm liste
      emit(_allFoods);
    } else {
      final filtered = _allFoods
          .where((food) =>
          food.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();

      emit(filtered);
    }
  }
}

