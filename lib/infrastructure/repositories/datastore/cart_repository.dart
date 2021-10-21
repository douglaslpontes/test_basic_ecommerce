import 'package:framework_test/domain/entities/cart_item.dart';
import 'package:framework_test/domain/entities/cart.dart';
import 'package:framework_test/domain/entities/product.dart';
import 'package:framework_test/infrastructure/repositories/datastore.dart';
import 'package:framework_test/utils/mapping_db.dart';

import 'db_config.dart';

/// create a sqlite cart repository
CartRepository newCartRepository() {
  return _CartRepository();
}

///
class _CartRepository extends CartRepository {
  @override
  Future<bool> addCartItem(CartItem cartItem) async {
    var _db = await DBManager.db();

    var result = await _db.insert(CartItemConstants.tableName, cartItem.toMap());
    if(result != 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> editCartItem(CartItem cartItem) async {
    var _db = await DBManager.db();

    var result = await _db.update(CartItemConstants.tableName, cartItem.toMap(), where: "${CartItemConstants.id} = ?", whereArgs: [cartItem.id]);
    if(result != 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<CartItem>> getCartItemsList(int cardId) async {
    var _db = await DBManager.db();

    final list = await _db.rawQuery('''
      SELECT CI.*, C.${CartConstants.created_date}, P.${ProductConstants.description}, P.${ProductConstants.price}, P.${ProductConstants.image_url} FROM ${CartItemConstants.tableName} CI
      INNER JOIN ${ProductConstants.tableName} P ON P.${ProductConstants.id} = CI.${CartItemConstants.product_id}
      INNER JOIN ${CartConstants.tableName} C ON C.${CartConstants.id} = CI.${CartItemConstants.cart_id}
      WHERE CI.${CartItemConstants.cart_id} = ?
    ''', [cardId]);

    return list.map((Map<String, dynamic> map) {
      final product = Product(id: map[CartItemConstants.product_id], price: map[ProductConstants.price], description: map[ProductConstants.description], imageUrl: map[ProductConstants.image_url]);
      final cart = Cart(id: map[CartItemConstants.cart_id], createdDate: DateTime.fromMillisecondsSinceEpoch(int.parse(map[CartConstants.created_date])));
  
      return CartItem.fromMap(map, product: product, cart: cart);
    }).toList();
  }

  @override
  Future<Cart> getCurrentCart() async {
    var _db = await DBManager.db();

    final list = await _db.query(CartConstants.tableName, where: "${CartConstants.checkout_date} IS NULL");
    if(list.isNotEmpty) {

      return Cart.fromMap(list.first);

    } else {
      var createdDate = DateTime.now().millisecondsSinceEpoch;

      var result = await _db.insert(CartConstants.tableName, {
        CartConstants.created_date: createdDate
      });

      if(result != 0) {
        return Cart(id: result, createdDate: DateTime.fromMillisecondsSinceEpoch(createdDate));
      } else {
        print('failed to get current cart');
        throw Exception();
      }
    }
  }

  @override
  Future<bool> removeCartItem(CartItem cartItem) async {
    var _db = await DBManager.db();

    var result = await _db.delete(CartItemConstants.tableName, where: "${CartItemConstants.id} = ?", whereArgs: [cartItem.id]);

    if(result != 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> checkout(Cart cart) async {
    var _db = await DBManager.db();

    final result = await _db.update(CartConstants.tableName, {
      CartConstants.created_date: cart.createdDate.millisecondsSinceEpoch.toString(),
      CartConstants.checkout_date: DateTime.now().millisecondsSinceEpoch.toString()
    }, where: "${CartConstants.id} = ?", whereArgs: [cart.id]);

    if(result > 0) {
      return true;
    } else {
      return false;
    }
  }

}