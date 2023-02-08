enum FCMType { onInitial, onMessage, onMessageOpenedApp, onBackground }

class FCMData {
  final FCMType type;
  final Map<String, dynamic> map;
  FCMData(this.map, {this.type = FCMType.onMessage});
}
