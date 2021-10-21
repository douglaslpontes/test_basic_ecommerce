import 'package:flutter/material.dart';
import 'package:framework_test/infrastructure/presentations/cart/cart_view.dart';
import 'package:framework_test/infrastructure/presentations/home/home_view.dart';
import 'package:framework_test/infrastructure/presentations/login/login_view.dart';

// ignore: avoid_classes_with_only_static_members
/// Route
class RouteConstants {
  /// login view route name
  static const login = '/login';

  /// home view route name
  static const home = '/home';

  /// cart view route name
  static const cart = '/cart';

  /// routes
  static final routes = <String, Widget Function(BuildContext)>{
    login: (_) => LoginView(),
    home: (_) => HomeView(),
    cart: (_) => CartView(),
  };
}
