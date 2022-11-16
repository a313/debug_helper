import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextExtension on BuildContext {
  to(Widget page) {
    Navigator.of(this).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => page,
    ));
  }
}

extension DateExtension on DateTime {
  String toStringFormat(String format) {
    return DateFormat(format).format(toLocal());
  }
}
