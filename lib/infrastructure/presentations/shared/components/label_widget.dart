import 'package:flutter/material.dart';

/// custom label widget
class LabelWidget extends StatelessWidget {
  /// label text
  final String text;
  final int? maxLines;

  /// default constructor
  const LabelWidget({required this.text, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        text,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyText2?.color,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
