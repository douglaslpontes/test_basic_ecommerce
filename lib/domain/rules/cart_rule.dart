import 'package:framework_test/domain/entities/cart_item.dart';

/// this is just an example of how I'd use a business rule using this file
String? validateQty(CartItem cartItem) {
  if (cartItem.qty == 0 || cartItem.qty < 0) {
    return 'Quantidade deve ser maior que zero!';
  }

  return null;
}