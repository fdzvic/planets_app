class HttpServiceResponse {
  bool? success;
  String? message;
  String? body;
  int? errorCode;

  HttpServiceResponse({
    this.success,
    this.message,
    this.body,
    this.errorCode,
  });

  HttpServiceResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    body = json['body'];
    errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['body'] = body;
    data['errorCode'] = errorCode;
    return data;
  }
}
