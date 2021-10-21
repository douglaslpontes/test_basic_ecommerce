import 'package:flutter/material.dart';
import 'package:framework_test/utils/mapping_routes.dart';

class LoginState extends ChangeNotifier {
  /// default constructor
  LoginState(this.context);

  Future<void> onLogin() async {
    Navigator.popAndPushNamed(context, RouteConstants.home);
  }

  ///
  BuildContext context;
  ///
  final TextEditingController username = TextEditingController();
  ///
  final TextEditingController password = TextEditingController();
}