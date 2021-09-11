import 'dart:convert';

import 'package:codelabs/app/core/utils/api_end_points.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import 'Message_C.dart';
import 'api_funtion.dart';
import 'base_response.dart';

class API_GetAllPageLoadData implements API_Function {
  static Future<bool> checkConnection() async {
    var connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<BaseResponse> GetNewsAPIData() async {
    try {
      final connectionResult = await checkConnection();
      if (connectionResult) {
        // debugger();
        http.Response response =
            await http.post(Uri.parse(ApiEndPoints.NewsAPI));
        print("response:" + response.body.toString());
        if (response.statusCode == 200) {
          return BaseResponse.fromJson(jsonDecode(response.body));
        } else {
          return BaseResponse(
              status: 0, data: null, responseMsg: Message_C.BAD_RESPONSE);
        }
      } else {
        return BaseResponse(
            status: 0, data: null, responseMsg: Message_C.NETWORK_ERROR);
      }
    } catch (e) {
      return BaseResponse(
        status: 0,
        data: null,
        responseMsg: Message_C.EXCEPTION_ERROR,
      );
    }
  }
}
