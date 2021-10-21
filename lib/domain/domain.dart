

import 'package:framework_test/domain/entities/cart.dart';
import 'package:framework_test/domain/entities/cart_item.dart';
import 'package:framework_test/domain/entities/product.dart';

/// cart usecase
abstract class CartUsecase {
  /// add cart item
  Future<bool> addCartItem(CartItem cartItem);
  /// remove cart item
  Future<bool> removeCartItem(CartItem cartItem);
  /// remove cart item
  Future<bool> editCartItem(CartItem cartItem);
  /// checkout cart
  Future<bool> checkout(Cart cart);
  /// returns the current cart
  Future<Cart> getCurrentCart();
  /// returns the current cart items
  Future<List<CartItem>> getCartItemsList(int cardId);
}

abstract class ProductUsecase {
  Future<List<Product>> getProductList();
}