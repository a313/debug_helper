import 'dart:developer';

import 'package:debug_helper/src/model/event_data.dart';
import 'package:debug_helper/src/model/exception_data.dart';
import 'package:debug_helper/src/model/fcm_data.dart';

import 'model/api_data.dart';

class DebugHelper {
  final bool shouldLog;

  List<ApiData> apiSuccess = [];
  List<ApiData> apiFailed = [];
  List<ExceptionData> exceptions = [];
  List<EventData> events = [];
  List<FCMData> notis = [];

  DebugHelper._(this.shouldLog);

  static DebugHelper? _instance;

  static DebugHelper getInstance() {
    return _instance ??= DebugHelper._(false);
  }

  static DebugHelper initializeApp({required bool shouldLog}) {
    return _instance ??= DebugHelper._(shouldLog);
  }

  static addApiSuccess(ApiData data) {
    if (_instance?.shouldLog ?? false) _instance?.apiSuccess.add(data);
  }

  static addApiFailed(ApiData data) {
    if (_instance?.shouldLog ?? false) _instance?.apiFailed.add(data);
  }

  static addException(ExceptionData data) {
    if (_instance?.shouldLog ?? false) _instance?.exceptions.add(data);
  }

  static addEvent(EventData data) {
    if (_instance?.shouldLog ?? false) _instance?.events.add(data);
  }

  static addRemoteMessage(FCMData data) {
    try {
      if (_instance?.shouldLog ?? false) _instance?.notis.add(data);
    } catch (e) {
      log(e.toString());
    }
  }

  static void clearApi() {
    _instance?.apiSuccess.clear();
    _instance?.apiFailed.clear();
  }

  static void clearEvent() {
    _instance?.events.clear();
  }

  static void clearException() {
    _instance?.exceptions.clear();
  }

  static void clearNotis() {
    _instance?.notis.clear();
  }

  static clear() {
    _instance?.apiSuccess.clear();
    _instance?.apiFailed.clear();
    _instance?.exceptions.clear();
    _instance?.events.clear();
    _instance?.notis.clear();
  }
}
