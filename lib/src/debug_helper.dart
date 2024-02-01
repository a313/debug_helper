import 'dart:math';

import 'package:debug_helper/src/model/event_data.dart';
import 'package:debug_helper/src/model/exception_data.dart';
import 'package:debug_helper/src/model/fcm_data.dart';
import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'model/api_data.dart';

class DebugHelper {
  final bool shouldLog;

  List<ApiData> apiSuccess = [];
  List<ApiData> apiFailed = [];
  List<ExceptionData> exceptions = [];
  List<EventData> events = [];
  List<FCMData> notis = [];

  int mShakeTimestamp = DateTime.now().millisecondsSinceEpoch;
  int mShakeCount = 0;

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
      debugPrint(e.toString());
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

  /// This constructor automatically calls [startListening] and starts detection and callbacks.
  static void autoStart(Function onPhoneShake) {
    accelerometerEventStream().listen(
      (event) {
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
          if (_instance!.mShakeTimestamp + 500 > now) {
            return;
          }

          // reset the shake count after 3 seconds of no shakes
          if (_instance!.mShakeTimestamp + 3000 < now) {
            _instance!.mShakeCount = 0;
          }

          _instance!.mShakeTimestamp = now;
          _instance!.mShakeCount++;

          if (_instance!.mShakeCount >= 1) {
            onPhoneShake();
          }
        }
      },
    );
  }
}
