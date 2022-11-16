import 'dart:developer';
import 'dart:math' hide log;

import 'package:debug_helper/src/catalog_scene.dart';
import 'package:debug_helper/src/model/event_data.dart';
import 'package:debug_helper/src/model/exception_data.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'src/model/api_data.dart';

class DebugHelper {
  final bool shouldLog;

  List<ApiData> apiSuccess = [];
  List<ApiData> apiFailed = [];
  List<ExceptionData> exceptions = [];
  List<EventData> events = [];

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

  static void start(GlobalKey<NavigatorState>? navigatorKey) {
    int mShakeTimestamp = DateTime.now().millisecondsSinceEpoch;
    int mShakeCount = 0;
    accelerometerEvents.listen((event) {
      double x = event.x;
      double y = event.y;
      double z = event.z;

      double gX = x / 9.80665;
      double gY = y / 9.80665;
      double gZ = z / 9.80665;
      // gForce will be close to 1 when there is no movement.
      double gForce = sqrt(gX * gX + gY * gY + gZ * gZ);

      if (gForce > 2.7) {
        var now = DateTime.now().millisecondsSinceEpoch;
        // ignore shake events too close to each other (500ms)
        if (mShakeTimestamp + 500 > now) {
          return;
        }

        // reset the shake count after 3 seconds of no shakes
        if (mShakeTimestamp + 3000 < now) {
          mShakeCount = 0;
        }

        mShakeTimestamp = now;
        mShakeCount++;

        if (mShakeCount >= 2) {
          _onPhoneShake(navigatorKey);
        }
      }
    });
  }

  static void _onPhoneShake(GlobalKey<NavigatorState>? navigatorKey) {
    if (navigatorKey == null) {
      navigatorKey?.currentState?.push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const DebugCatalogPage(),
        ),
      );
    } else {
      log('Cant navigate, please check your navigatorKey',
          name: "DEBUG HELPER");
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

  static clear() {
    _instance?.apiSuccess.clear();
    _instance?.apiFailed.clear();
    _instance?.exceptions.clear();
    _instance?.events.clear();
  }
}
