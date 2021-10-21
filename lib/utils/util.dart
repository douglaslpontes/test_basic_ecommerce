import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Global date time format
String dateTimeFormat(BuildContext c, DateTime d) {
  final l = Localizations.localeOf(c);
  return DateFormat.yMd(l.toString()).add_Hm().format(d);
}

/// Global date format
String dateFormat(BuildContext c, DateTime d) {
  final l = Localizations.localeOf(c);
  return DateFormat.yMd(l.toString()).format(d);
}

/// Converts a double value to monetary value
String monetaryValue(BuildContext c, double value) {
  final l = Localizations.localeOf(c);
  final cf = NumberFormat.currency(locale: l.languageCode, decimalDigits: 2, symbol: '\$');

  return cf.format(value);
}