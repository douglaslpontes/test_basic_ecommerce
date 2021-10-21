import 'dart:io';

import 'package:flutter/material.dart';
import 'package:framework_test/domain/domain.dart';
import 'package:framework_test/domain/entities/cart.dart';
import 'package:framework_test/domain/entities/cart_item.dart';
import 'package:framework_test/utils/util.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

///
class CartState extends ChangeNotifier {
  ///
  CartState(this.context) {
    _init();
  }

  /// first load
  _init() async {
    final usecase = Provider.of<CartUsecase>(context, listen: false);
    currentCart = await usecase.getCurrentCart();
    cartItems.addAll(await usecase.getCartItemsList(currentCart!.id));
    notifyListeners();
  }

  /// get current cart items
  void getCartItems() async {
    cartItems.clear();
    final usecase = Provider.of<CartUsecase>(context, listen: false);
    cartItems.addAll(await usecase.getCartItemsList(currentCart!.id));
    notifyListeners();
  }

  /// removes the item from cart
  void removeCartItem(CartItem cartItem) async {
    final usecase = Provider.of<CartUsecase>(context, listen: false);
    final result = await usecase.removeCartItem(cartItem);
    if(result == true) {
      getCartItems();
    }
  }

  void checkout() async {
    final usecase = Provider.of<CartUsecase>(context, listen: false);
    final result = await usecase.checkout(currentCart!);
    if(result == true) {
      final pdf = pw.Document();

      pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context c) {
          return pw.Column(
            children: List.generate(cartItems.length, (index) {
              var cartItem = cartItems[index];

              return pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(cartItem.product.description),
                    pw.Text(monetaryValue(context, cartItem.product.price)),
                  ]
                ),
              );
            })
          );
      }));

      final output = await getApplicationDocumentsDirectory();
      final file = File("${output.path}/${currentCart!.id}.pdf");
      await file.writeAsBytes(await pdf.save());
      Navigator.pop(context, true);

      OpenFile.open(file.path);
    }
  }

  ///
  BuildContext context;

  Cart? currentCart;

  List<CartItem> cartItems = [];
}