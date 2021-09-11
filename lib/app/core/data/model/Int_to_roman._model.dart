class IntToRomanModel {
  String intValue = "";
  String romanValue = "";

  IntToRomanModel({
    required String intValue,
    required String romanValue,
  }) {
    this.intValue = intValue;
    this.romanValue = romanValue;
  }

  @override
  String toString() {
    return romanValue;
  }
}
