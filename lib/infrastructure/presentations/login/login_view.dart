import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:framework_test/infrastructure/presentations/shared/components/button_widget.dart';
import 'package:framework_test/infrastructure/presentations/shared/components/input_widget.dart';
import 'package:framework_test/utils/mapping_key.dart';
import 'package:provider/provider.dart';
import 'login_state.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? token;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginState(context),
      child: Consumer<LoginState>(
        builder: (context, state, _) {
          return Scaffold(
            body: Stack(
              children: [
                Container(color: Theme.of(context).appBarTheme.color),
                // Align(
                //   alignment: Alignment.center,
                //   child: SvgPicture.asset(ImagesConstants.logoHeader, height: 200),
                // ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    height: MediaQuery.of(context).size.height / 3,
                    duration: Duration(milliseconds: 500),
                    child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  InputWidget(
                                    key: KeyConstants.inpEmail,
                                    controller: state.username,
                                    hintText: 'Digite um email',
                                    prefixIcon: Icon(Icons.email_sharp),
                                  ),
                                  Container(height: 10),
                                  InputWidget(
                                    key: KeyConstants.inpPass,
                                    controller: state.password,
                                    hintText: 'Digite uma senha',
                                    prefixIcon: Icon(Icons.vpn_key_sharp),
                                  ),
                                ],
                              ),
                              Container(
                                child: ButtonWidget(
                                  key: KeyConstants.btnConnect,
                                  text: 'Conectar',
                                  onPressed: state.onLogin,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
