import 'package:flutter/material.dart';
import 'package:framework_test/domain/domain.dart';
import 'package:framework_test/domain/entities/cart.dart';
import 'package:framework_test/domain/entities/cart_item.dart';
import 'package:framework_test/domain/entities/product.dart';
import 'package:framework_test/utils/mapping_routes.dart';
import 'package:provider/provider.dart';

class HomeState extends ChangeNotifier {
  ///
  HomeState(this.context) {
    _init();
  }

  /// loads everything thats necessary
  _init() async {
    final productUsecase = Provider.of<ProductUsecase>(context, listen: false);
    _products.addAll(await productUsecase.getProductList());
    notifyListeners();
  }

  /// get qty of items in the current cart
  Future<int> getCartItemCount() async {
    final usecase = Provider.of<CartUsecase>(context, listen: false);
    if(currentCart == null) {
      currentCart = await usecase.getCurrentCart();
    }
    final list = await usecase.getCartItemsList(currentCart!.id);
    return list.length;
  }

  /// check if this product is already inside cart
  Future<bool> checkIfItsOnCart(int productId) async {
    final usecase = Provider.of<CartUsecase>(context, listen: false);
    
    if(currentCart == null) {
      currentCart = await usecase.getCurrentCart();
    }

    final list = await usecase.getCartItemsList(currentCart!.id);

    if(list.indexWhere((element) => element.product.id == productId) > -1) {
      return true;
    } else {
      return false;
    }
  }

  /// adds a cart item to current cart in the database
  void addCartItem(Product product) async {
    final usecase = Provider.of<CartUsecase>(context, listen: false);
    final result = await usecase.addCartItem(CartItem(qty: 1, cart: currentCart!, product: product));
    if(result == true) {
      notifyListeners();
    }
  }

  /// opens cart screen and await to udpate future builders
  void openCart() async {
    final result = await Navigator.pushNamed(context, RouteConstants.cart);
    
    if(result == true) {
      currentCart = null;
      notifyListeners();
    }

    notifyListeners();
  }

  // removeCartItem(Product product) async {
  //   final usecase = Provider.of<CartUsecase>(context, listen: false);
  //   final result = await usecase.removeCartItem(CartItem(qty: 1, cart: currentCart!, product: product));
  //   if(result == true) {
  //     notifyListeners();
  //   }
  // }

  ///
  BuildContext context;
  
  ///
  Cart? currentCart;
  ///
  final List<Product> _products = [];
  ///
  List<Product> get products => _products;

}