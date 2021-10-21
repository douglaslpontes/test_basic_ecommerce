import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:framework_test/infrastructure/presentations/home/home_state.dart';
import 'package:framework_test/infrastructure/presentations/shared/components/button_widget.dart';
import 'package:framework_test/utils/mapping_routes.dart';
import 'package:framework_test/utils/util.dart';
import 'package:provider/provider.dart';

///
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeState(context),
      child: Consumer<HomeState>(
        builder: (context, state, _) => Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            actions: [
              FutureBuilder(
                future: state.getCartItemCount(),
                initialData: 0,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    return GestureDetector(
                      onTap: () => state.openCart(),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, top: 8),
                        child: Badge(                        
                          badgeColor: Colors.white,
                          badgeContent: Text('${snapshot.data}'),
                          child: Icon(Icons.shopping_cart),
                        ),
                      ),
                    );
                  } else if(snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
          body: Container(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(state.products.length, (index) {
                var product = state.products[index];
    
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(product.imageUrl, fit: BoxFit.contain)
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product.description),
                            Text(monetaryValue(context, product.price)),
                          ],
                        ),
                        FutureBuilder(
                          future: state.checkIfItsOnCart(product.id),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if(snapshot.hasData) {
                              if(snapshot.data == true) {
                                return SizedBox();
                              } else {
                                return ButtonWidget(text: 'Adicionar', onPressed: () => state.addCartItem(product));
                              }
                            } else if(snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }

                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}