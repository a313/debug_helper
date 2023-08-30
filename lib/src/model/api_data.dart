class ApiData {
  final String method;
  final dynamic url;
  final dynamic header;
  final dynamic params;
  final dynamic response;
  final DateTime requestDate;
  final int? statusCode;
  final String? exception;
  final String? bodyString;
  final int? responseTime;
  final dynamic extraData;

  ApiData({
    required this.method,
    required this.url,
    required this.header,
    required this.params,
    required this.response,
    required this.requestDate,
    this.statusCode,
    this.exception,
    this.bodyString,
    this.responseTime,
    this.extraData,
  });
}
