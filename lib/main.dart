import 'package:flutter/material.dart';
import 'package:framework_test/domain/domain.dart';
import 'package:framework_test/domain/usecases/cart_usecase.dart';
import 'package:framework_test/domain/usecases/product_usecase.dart';
import 'package:framework_test/infrastructure/repositories/datastore/cart_repository.dart';
import 'package:framework_test/infrastructure/repositories/datastore/product_repository.dart';
import 'package:framework_test/utils/mapping_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  get _defaultThemeData => ThemeData(
      primarySwatch: MaterialColor(0xFF1b262c, {
        50: Color.fromRGBO(255, 106, 18, .1),
        100: Color.fromRGBO(255, 106, 18, .2),
        200: Color.fromRGBO(255, 106, 18, .3),
        300: Color.fromRGBO(255, 106, 18, .4),
        400: Color.fromRGBO(255, 106, 18, .5),
        500: Color.fromRGBO(255, 106, 18, .6),
        600: Color.fromRGBO(255, 106, 18, .7),
        700: Color.fromRGBO(255, 106, 18, .8),
        800: Color.fromRGBO(255, 106, 18, .9),
        900: Color.fromRGBO(255, 106, 18, 1),
      }),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF0e97ff),
      ),
      appBarTheme: AppBarTheme(
        color: Color(0xFFffc72b),
        titleTextStyle: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w700),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      scaffoldBackgroundColor: Color(0xFFE4E6E9),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Color(0xFF222E34)),
          overlayColor: MaterialStateProperty.all(
            Color.fromRGBO(255, 106, 18, .2),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: const Color(0xff1b262c),
      ),
      accentIconTheme: IconThemeData(
        color: const Color(0xFF1E90FF),
      ),
      textTheme: TextTheme(
        bodyText2: TextStyle(color: Color(0xFF1B262C), fontSize: 16),
        subtitle2: TextStyle(fontWeight: FontWeight.w700, color: Color(0xff1b262c), fontSize: 18),
      ),
    );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CartUsecase>(create: (_) => newCartUsecase(newCartRepository())),
        Provider<ProductUsecase>(create: (_) => newProductUsecase(newProductRepository())),
      ],
      child: MaterialApp(
        title: 'framework test',
        theme: _defaultThemeData,
        debugShowCheckedModeBanner: false,
        routes: RouteConstants.routes,
        initialRoute: RouteConstants.login
      ),
    );
  }
}