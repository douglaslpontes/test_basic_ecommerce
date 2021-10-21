import 'package:framework_test/domain/domain.dart';
import 'package:framework_test/domain/entities/cart_item.dart';
import 'package:framework_test/domain/entities/cart.dart';
import 'package:framework_test/domain/rules/cart_rule.dart';
import 'package:framework_test/infrastructure/repositories/datastore.dart';

/// Create a locale use case
CartUsecase newCartUsecase(CartRepository repo) => _CartUsecase(repo);


/// usecase its where I put all the business rules before reaching my database
class _CartUsecase extends CartUsecase {
  _CartUsecase(this.repo);
  final CartRepository repo;

  @override
  Future<bool> addCartItem(CartItem cartItem) {
    final value = validateQty(cartItem);
    if (value != null) {
      throw Exception(value);
    }
  
    return repo.addCartItem(cartItem);
  }

  @override
  Future<bool> editCartItem(CartItem cartItem) => repo.editCartItem(cartItem);

  @override
  Future<List<CartItem>> getCartItemsList(int cardId) => repo.getCartItemsList(cardId);

  @override
  Future<Cart> getCurrentCart() => repo.getCurrentCart();

  @override
  Future<bool> removeCartItem(CartItem cartItem) => repo.removeCartItem(cartItem);

  @override
  Future<bool> checkout(Cart cart) => repo.checkout(cart);
}