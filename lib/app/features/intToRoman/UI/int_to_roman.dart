import 'package:codelabs/app/core/data/model/Int_to_roman._model.dart';
import 'package:codelabs/app/core/utils/constants.dart';
import 'package:codelabs/app/core/utils/validator.dart';
import 'package:codelabs/app/core/widget/Elv_Button.dart';
import 'package:codelabs/app/core/widget/edittext_widget.dart';
import 'package:codelabs/app/features/intToRoman/Controller/getx_int_to_roman_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class IntToRomanScreen extends StatefulWidget {
  const IntToRomanScreen({key}) : super(key: key);
  final String title = 'Task';

  @override
  State<IntToRomanScreen> createState() => _IntToRomanScreenState();
}

class _IntToRomanScreenState extends State<IntToRomanScreen> {
  final GetX_IntToRoman_Controller _getX_IntToRoman_Controller =
      Get.put(GetX_IntToRoman_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          backgroundColor: KColor.kPrimaryColor,
          child: Icon(Icons.add),
          onPressed: () => {_creat_callback()},
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _body(),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Obx(() {
      if (_getX_IntToRoman_Controller.int_to_roman_list.isNotEmpty) {
        return buildListViewBuilder(
            _getX_IntToRoman_Controller.int_to_roman_list);
      } else {
        return Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.hourglass_empty,
                  color: KColor.kPrimaryLightColor,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "No Data Found",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: KColor.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: KColor.kPrimaryLightColor,
                  ),
                )
              ],
            ),
          ),
        );
      }
    });
  }

  Widget buildListViewBuilder(List<IntToRomanModel> _list) {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          //shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: _list.length,
          itemBuilder: (context, index) => _singleCard(_list[index], index),
        );
      }),
    );
  }

  Widget _singleCard(IntToRomanModel intToRomanModel, int index) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: KColor.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                color: KColor.background,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Integer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: KColor.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          intToRomanModel.intValue,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: KColor.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: -0.2,
                            color: KColor.darkText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Roman',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: KColor.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              intToRomanModel.romanValue,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: KColor.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: -0.2,
                                color: KColor.darkText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              Get.defaultDialog(
                                  title: "Alert".toUpperCase(),
                                  middleText:
                                      "Are you sure you want to delete?",
                                  textCancel: "No",
                                  onCancel: () {},
                                  textConfirm: "Yes",
                                  cancelTextColor: KColor.darkerText,
                                  confirmTextColor: KColor.white,
                                  buttonColor: KColor.darkerText,
                                  onConfirm: () {
                                    _getX_IntToRoman_Controller
                                        .int_to_roman_list
                                        .removeAt(index);

                                    Get.back();
                                  });
                            },
                            child: const Icon(
                              Icons.clear,
                              color: KColor.kPrimaryLightColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                color: KColor.background,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _creat_callback() {
    Get.dialog(CreateAlertDialog(
      title: "title",
    ));
  }
}

/************************************
    ///Dialog Class
 ************************************/

class CreateAlertDialog extends StatefulWidget {
  final String? title;

  CreateAlertDialog({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  _CreateAlertDialogState createState() => _CreateAlertDialogState();
}

class _CreateAlertDialogState extends State<CreateAlertDialog> {
  GetX_IntToRoman_Controller _getX_IntToRoman_Controller = Get.find();

  TextEditingController _text_controller_value = TextEditingController();
  TextEditingController _text_controller_to = TextEditingController();
  TextEditingController _text_controller_from = TextEditingController();

  static const List<int> arabianRomanNumbers = [
    1000,
    900,
    500,
    400,
    100,
    90,
    50,
    40,
    10,
    9,
    5,
    4,
    1
  ];

  static const List<String> romanNumbers = [
    "M",
    "CM",
    "D",
    "CD",
    "C",
    "XC",
    "L",
    "XL",
    "X",
    "IX",
    "V",
    "IV",
    "I"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Object? _obj = ModalRoute?.of(context)?.settings.arguments;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding: EdgeInsets.all(30.0),
      backgroundColor: KColor.background,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext _context) {
    return GestureDetector(
      // onTap: () => FocusKeyboard.dismissKeyboard(),
      child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(
                    Icons.code_outlined,
                    color: KColor.kPrimaryLightColor,
                  ),
                  title: Text(
                    "Int To Roman",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: KColor.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: KColor.kPrimaryLightColor,
                    ),
                  ),
                ),
                SingleRow_Edit_Text(
                  title: "Enter Int Value",
                  inputType: TextInputType.number,
                  controller: _text_controller_value,
                  gestureTapCallback: () => _onValueTap(),
                ),
                Divider(),
                Text("OR"),
                Divider(),
                SingleRow_Edit_Text(
                  title: "Enter From Value",
                  inputType: TextInputType.number,
                  controller: _text_controller_from,
                  gestureTapCallback: () => _onFromValueTap(),
                ),
                SingleRow_Edit_Text(
                  title: "Enter To Value",
                  inputType: TextInputType.number,
                  controller: _text_controller_to,
                  gestureTapCallback: () => _onToValueTap(),
                ),
                Divider(),
                Elv_Button(
                    labelText: "OK",
                    callback: () => _save_touch_point_callback())
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _doValidation() {
    bool _validate;
    if (_text_controller_value.value.text == "" &&
        _text_controller_from.value.text == "" &&
        _text_controller_to.value.text == "") {
      _validate = Validator.validator([
        NestedValidator(
            isValidate: Validator.validateEditText(_text_controller_value.text),
            errorMessage: "Please Enter Int Value"),
      ]);
    } else if (_text_controller_from.value.text == "") {
      _validate = Validator.validator([
        NestedValidator(
            isValidate: Validator.validateEditText(_text_controller_value.text),
            errorMessage: "Please Enter From Value"),
      ]);
    } else if (_text_controller_to.value.text == "") {
      _validate = Validator.validator([
        NestedValidator(
            isValidate: Validator.validateEditText(_text_controller_value.text),
            errorMessage: "Please Enter To Value"),
      ]);
    } else if (_text_controller_from.value.text != "" &&
        _text_controller_to.value.text != "") {
      int from = int.parse(_text_controller_from.value.text);
      int to = int.parse(_text_controller_to.value.text);

      if (to < from) {
        _validate = Validator.validator([
          NestedValidator(
              isValidate:
                  Validator.validateEditText(_text_controller_value.text),
              errorMessage: "To value must be grater than from value"),
        ]);
      } else {
        _validate = true;
      }
    } else {
      _validate = true;
    }

    return _validate;
  }

  _onValueTap() async {
    _text_controller_from.clear();
    _text_controller_to.clear();
  }

  _onFromValueTap() async {
    _text_controller_value.clear();
  }

  _onToValueTap() async {
    _text_controller_value.clear();
  }

  _save_touch_point_callback() async {
    if (_doValidation()) {
      try {
        //debugger();
        await _getX_IntToRoman_Controller.clearFetchList();
        if (_text_controller_value.value.text != "") {
          int value = int.parse(_text_controller_value.value.text);
          String roman =
              await intToRoman(int.parse(_text_controller_value.value.text));
          _getX_IntToRoman_Controller.int_to_roman_list.add(IntToRomanModel(
            intValue: value.toString(),
            romanValue: roman,
          ));
        } else {
          int fromValue = int.parse(_text_controller_from.value.text);
          int toValue = int.parse(_text_controller_to.value.text);

          for (var i = fromValue; i <= toValue; i++) {
            String value = await intToRoman(i);

            _getX_IntToRoman_Controller.int_to_roman_list.add(
                IntToRomanModel(intValue: i.toString(), romanValue: value));
          }
        }
      } catch (exception) {
        Get.back();
        _clearField();
      }

      // await Future.delayed(Duration(milliseconds: 1000));
      Get.back();
    }
  }

  String intToRoman(int input) {
    var num = input;

    if (num < 0) {
      return "";
    } else if (num == 0) {
      return "nulla";
    }

    final builder = StringBuffer();
    for (var a = 0; a < arabianRomanNumbers.length; a++) {
      final times = (num / arabianRomanNumbers[a])
          .truncate(); // equals 1 only when arabianRomanNumbers[a] = num
      // executes n times where n is the number of times you have to add
      // the current roman number value to reach current num.
      builder.write(romanNumbers[a] * times);
      num -= times *
          arabianRomanNumbers[
              a]; // subtract previous roman number value from num
    }

    return builder.toString();
  }

  _clearField() {
    _text_controller_value.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
