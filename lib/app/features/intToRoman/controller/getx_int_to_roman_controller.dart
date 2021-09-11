import 'package:codelabs/app/core/data/model/Int_to_roman._model.dart';
import 'package:get/get.dart';

class GetX_IntToRoman_Controller extends GetxController {
  var isLoading = false.obs;
  var isLoading_IntToRoman = false.obs;

  List<IntToRomanModel> int_to_roman_list = <IntToRomanModel>[].obs;

  void setIsLoading(bool _val) {
    isLoading.value = _val;
  }

  @override
  void onInit() {
    //loadOrderApproval();
    super.onInit();
  }

  void setIntToRoman(List<IntToRomanModel> _list) {
    int_to_roman_list = _list;
  }

  clearFetchList() {
    int_to_roman_list.clear();
  }
}
