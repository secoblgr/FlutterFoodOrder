import 'foods.dart';

class CartItem {
  final Foods food;
  int quantity;

  CartItem({
    required this.food,
    this.quantity = 1,
  });

  int get totalPrice => food.price * quantity;
}
