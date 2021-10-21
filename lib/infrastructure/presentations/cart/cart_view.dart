import 'package:flutter/material.dart';
import 'package:framework_test/infrastructure/presentations/cart/cart_state.dart';
import 'package:framework_test/utils/util.dart';
import 'package:provider/provider.dart';

///
class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => CartState(c),
      child: Consumer<CartState>(
        builder: (context, state, _) => Scaffold(
          appBar: AppBar(
            title: Text('Carrinho'),
          ),
          body: ListView.builder(
            itemCount: state.cartItems.length,
            itemBuilder: (_, index) {
              var cartItem = state.cartItems[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.network(cartItem.product.imageUrl)
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cartItem.product.description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text(monetaryValue(context, cartItem.product.price)),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => state.removeCartItem(cartItem),
                            icon: Icon(Icons.delete, size: 30)
                          )
                        ],
                      ),
                    ],
                  ),
                )
              );
            }
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => state.checkout(),
            child: Icon(Icons.save)
          )
        ),
      ),
    );
  }
}