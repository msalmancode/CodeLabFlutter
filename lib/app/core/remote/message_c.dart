import 'base_response.dart';

class Message_C {
  static const String NETWORK_ERROR = "NETWORK_ERROR";
  static const String BAD_RESPONSE = "BAD_RESPONSE";
  static const String EXCEPTION_ERROR = "EXCEPTION_ERROR";

  static bool check_Response({required BaseResponse baseResponse}) {
    if (baseResponse.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  static String msgToPrint(String? val) {
    switch (val) {
      case NETWORK_ERROR:
        return "Internet connection problem.";
      case BAD_RESPONSE:
        return "Something went wrong from server due to bad request.";
      case EXCEPTION_ERROR:
        return "Something went wrong.";
      default:
        return "Sorry, Some Internal Server Error!";
    }
  }
}
