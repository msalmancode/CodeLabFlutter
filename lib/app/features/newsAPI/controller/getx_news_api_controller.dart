import 'package:codelabs/app/core/data/model/news_api_response_mode.dart';
import 'package:codelabs/app/core/remote/Message_C.dart';
import 'package:codelabs/app/core/remote/api_all_data.dart';
import 'package:codelabs/app/core/remote/api_funtion.dart';
import 'package:codelabs/app/core/widget/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GetX_New_Api_Controller extends GetxController {
  var isLoading = false.obs;

  List<NewsApiResponseModel> newsList = <NewsApiResponseModel>[].obs;
  List<NewsApiResponseModel> searchNewsList = <NewsApiResponseModel>[].obs;

  API_Function _api_function = API_GetAllPageLoadData();

  void setIsLoading(bool _val) {
    isLoading.value = _val;
  }

  @override
  void onInit() {
    super.onInit();
  }

  //for search
  void addIntoSearchResult(NewsApiResponseModel newsApiResponseModel) {
    searchNewsList.add(newsApiResponseModel);
  }

  void clearSearchResult() {
    searchNewsList.clear();
  }

  void setMyLeads(List<NewsApiResponseModel> _list) {
    newsList = _list;
  }

  fetchNewsDataFromApi() async {
    setIsLoading(true);
    final response = await _api_function.GetNewsAPIData();
    //debugger();
    if (Message_C.check_Response(baseResponse: response)) {
      try {
        if (response.data != null) {
          loadNewsData(response.data);

          print("GOOD-Msg-:" + response.responseMsg.toString());
        } else {
          print("Error-Msg-else:" + response.responseMsg.toString());
        }
      } catch (e) {
        print("Error-Msg-Catch:" + e.toString());
      }
    } else {
      print("Error-Msg-CheckResponse:" +
          Message_C.msgToPrint(response.responseMsg.toString()));

      showSnackBar(
          title: "Error Message,",
          datatoShow: Message_C.msgToPrint(response.responseMsg.toString()));
      await Future.delayed(Duration(seconds: 2));
    }
    setIsLoading(false);
  }

  loadNewsData(dynamic responseData) async {
    newsList.clear();
    responseData.forEach((each) {
      newsList.add(NewsApiResponseModel.fromJson(each));
    });
  }
}
