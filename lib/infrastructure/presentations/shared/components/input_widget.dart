import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// custom component input
class InputWidget extends StatefulWidget {
  /// place holder text field
  String? hintText;

  /// text field controller
  TextEditingController controller;

  /// onChanged function
  Function(String val)? onChanged;

  /// input enabled flag
  bool? enabled;

  /// big input flag
  bool bigger;

  /// max length
  int? maxLength;

  int? minLines;

  int? maxLines;

  /// big input flag
  TextInputType? inputType = TextInputType.text;

  final String? warning;

  List<TextInputFormatter>? inputFormatters;

  Widget? prefixIcon;

  bool expands;

  /// default constructor
  InputWidget({
    this.hintText,
    required this.controller,
    this.onChanged,
    this.enabled,
    this.bigger = false,
    this.inputType = TextInputType.text,
    this.maxLength,
    this.warning,
    this.inputFormatters,
    this.prefixIcon,
    this.minLines,
    this.maxLines,
    this.expands = false,
    Key? key,
  }) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  _border() {
    if (widget.warning != null && widget.controller.text == '') {
      return Colors.red[400];
    } else {
      return Color.fromRGBO(34, 46, 52, .2);
    }
  }

  int? get minLines {
    return widget.minLines;
  }

  int? get maxLines {
    var max = widget.maxLines ?? 0;
    var min = minLines ?? 0;

    if (min > max && max > 0) {
      return min;
    }

    return widget.maxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
          height: widget.bigger ? 60 : 44,
          decoration: BoxDecoration(
            color: widget.enabled != null && widget.enabled == false ? Colors.grey.shade300 : Colors.white,
            border: Border.all(
              color: _border(),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            expands: widget.expands,
            enabled: widget.enabled,
            controller: widget.controller,
            keyboardType: widget.inputType,
            inputFormatters: widget.inputFormatters,
            onChanged: (t) {
              if (widget.onChanged != null) widget.onChanged!(t);
              setState(() {});
            },
            cursorHeight: 20,
            cursorWidth: 0.7,
            maxLength: widget.maxLength,
            minLines: minLines,
            maxLines: maxLines,
            cursorColor: Color(0xffFF6A12),
            style: TextStyle(
              fontSize: 14,
            ),
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              hintStyle: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
              ),
              fillColor: Colors.grey.shade300,
              filled: widget.enabled != null && widget.enabled == false ? true : false,
              contentPadding: EdgeInsets.only(bottom: 10, top: 0),
              hintText: widget.hintText,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
        widget.warning == null
            ? Container()
            : widget.controller.text == ''
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 0, top: 4),
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              widget.warning ?? '',
                              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
      ],
    );
  }
}
