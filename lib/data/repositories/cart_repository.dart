import '../entity/cart_item.dart';
import '../entity/foods.dart';

class CartRepository {
  final List<CartItem> _cartItems = [];

  List<CartItem> getCartItems() => _cartItems;

  void addToCart(Foods food, {int quantity = 1}) {
    final index =
    _cartItems.indexWhere((item) => item.food.id == food.id);

    if (index >= 0) {
      _cartItems[index].quantity += quantity;
    } else {
      _cartItems.add(CartItem(food: food, quantity: quantity));
    }
  }

  void removeFromCart(int foodId) {
    _cartItems.removeWhere((e) => e.food.id == foodId);
  }

  void increaseQuantity(int foodId) {
    _cartItems.firstWhere((e) => e.food.id == foodId).quantity++;
  }

  void decreaseQuantity(int foodId) {
    final item = _cartItems.firstWhere((e) => e.food.id == foodId);
    if (item.quantity > 1) {
      item.quantity--;
    }
  }

  double getTotalPrice() {
    return _cartItems.fold(
      0,
          (sum, item) => sum + item.totalPrice,
    );
  }

  void clearCart() {
    _cartItems.clear();
  }
}
