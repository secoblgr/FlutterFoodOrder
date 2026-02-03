import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:project/data/entity/foods.dart';
import 'package:project/data/entity/foods_response.dart';

class FoodRepository {
  static const baseUrl =
      "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";

  List<Foods> parseFoods(dynamic response) {
    return FoodsResponse.fromJson(response).foods;
  }

  Future<List<Foods>> getFoods() async {
    var response = await Dio().get(baseUrl);
    final Map<String, dynamic> jsonData = response.data is String
        ? json.decode(response.data)
        : response.data;

    return FoodsResponse.fromJson(jsonData).foods;
  }

  Future<List<Foods>> search(List<Foods> foods, String search) async {
    final keyword = search.toLowerCase().trim();
    if (keyword.isEmpty) {
      return foods;
    }
    return foods
        .where((food) => food.name.toLowerCase().contains(keyword))
        .toList();
  }


}
