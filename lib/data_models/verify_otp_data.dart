import 'dart:convert';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 11:06 AM
///

VerifyOtpData verifyOtpDataFromJson(String str) =>
    VerifyOtpData.fromJson(json.decode(str));

String verifyOtpDataToJson(VerifyOtpData data) => json.encode(data.toJson());

class VerifyOtpData {
  VerifyOtpData({
    required   this.accessToken,
  });

  String accessToken;

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) => VerifyOtpData(
        accessToken: json["accessToken"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
      };
}
