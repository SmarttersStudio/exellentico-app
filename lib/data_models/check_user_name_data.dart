import 'dart:convert';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 7:13 AM
///

CheckUserNameData checkUserNameDataFromJson(String str) =>
    CheckUserNameData.fromJson(json.decode(str));

String checkUserNameDataToJson(CheckUserNameData data) =>
    json.encode(data.toJson());

class CheckUserNameData {
  CheckUserNameData({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory CheckUserNameData.fromJson(Map<String, dynamic> json) =>
      CheckUserNameData(
        result: json.containsKey('result')
            ? json["result"] != null ? json["result"] : false
            : null,
        message: json.containsKey('message')
            ? json["message"] != null ? json["message"] : ''
            : null,
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };
}
