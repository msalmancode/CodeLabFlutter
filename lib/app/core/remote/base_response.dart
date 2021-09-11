class BaseResponse {
  int? status;
  String? responseMsg;
  dynamic data;

  BaseResponse.constructor();

  BaseResponse({this.status, this.responseMsg, this.data});

  factory BaseResponse.fromJson(dynamic json) {
    return BaseResponse(status: json["status-code"], data: json["data"]);
  }

  @override
  String toString() {
    return 'BaseResponse{status: $status, responseMsg: $responseMsg data: $data}';
  }
}
