import 'package:flutter/foundation.dart';

class ExceptionData {
  final FlutterErrorDetails? flutterError;
  final Object? error;
  final StackTrace? stack;
  ExceptionData({
    this.flutterError,
    this.error,
    this.stack,
  });
}
