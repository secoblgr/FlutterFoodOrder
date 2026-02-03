import 'package:project/data/entity/foods.dart';

class FoodsResponse {
  List<Foods> foods;

  FoodsResponse({required this.foods});

  factory FoodsResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;

    List<Foods> foodsList = jsonArray.map((e) => Foods.fromJson(e)).toList();

    return FoodsResponse(foods: foodsList);
  }
}
