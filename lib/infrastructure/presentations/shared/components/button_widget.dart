import 'package:flutter/material.dart';

/// custom component button
class ButtonWidget extends StatelessWidget {
  /// inside text
  String text;

  /// callback
  Function()? onPressed;

  ///default constructor
  ButtonWidget({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF1E90FF)), minimumSize: MaterialStateProperty.all(Size(double.infinity, 40))),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 16)));
  }
}
