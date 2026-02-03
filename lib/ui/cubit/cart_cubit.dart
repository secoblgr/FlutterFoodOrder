import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/cart_item.dart';
import '../../data/entity/foods.dart';
import '../../data/repositories/cart_repository.dart';

class CartCubit extends Cubit<List<CartItem>> {
  final CartRepository _repo;

  CartCubit(this._repo) : super([]);

  void loadCart() {
    emit(List.from(_repo.getCartItems()));
  }

  void addToCart(Foods food, {int quantity = 1}) {
    _repo.addToCart(food, quantity: quantity);
    loadCart();
  }

  void remove(int foodId) {
    _repo.removeFromCart(foodId);
    loadCart();
  }

  void increase(int foodId) {
    _repo.increaseQuantity(foodId);
    loadCart();
  }

  void decrease(int foodId) {
    _repo.decreaseQuantity(foodId);
    loadCart();
  }

  double get totalPrice => _repo.getTotalPrice();

  void clear() {
    _repo.clearCart();
    loadCart();
  }
}
