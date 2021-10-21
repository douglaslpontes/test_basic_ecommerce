import 'package:framework_test/domain/entities/cart.dart';
import 'package:framework_test/domain/entities/product.dart';
import 'package:framework_test/utils/mapping_db.dart';

///
class CartItem {
  /// Default constructor
  CartItem({
    required this.qty,
    required this.product,
    required this.cart,
    this.id
  });

  /// from database
  CartItem.fromMap(Map<String, dynamic> map, {
    required this.product,
    required this.cart
  }) : id = map[CartItemConstants.id], qty = map[CartItemConstants.qty];

  /// map to insert on database
  Map<String, dynamic> toMap() => {
    CartItemConstants.id: id,
    CartItemConstants.qty: qty,
    CartItemConstants.product_id: product.id,
    CartItemConstants.cart_id: cart.id
  };

  int? id;
  int qty;
  Product product;
  Cart cart;
}