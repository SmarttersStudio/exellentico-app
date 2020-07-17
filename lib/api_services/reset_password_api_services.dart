import 'package:ecommerceapp/api_services/base_api.dart';
import 'package:ecommerceapp/config/api_routes.dart';
import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/data_models/verify_otp_data.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 8:21 AM
///

Future<String> sendPasswordResetEmail({@required String email}) async {
  final result = await ApiCall.generalApiCall(
      ApiRoutes.forgetPassword, RequestMethod.create,
      body: {"email": email, "target": "email"});
  return result.data['message'];
}

Future<VerifyOtpData> verifyOtpForPasswordReset(
    {@required int pin, @required String email}) async {
  final result = await ApiCall.generalApiCall(
      ApiRoutes.verifyMailOTP, RequestMethod.create,
      body: {"otp": pin, "email": email});
  return VerifyOtpData.fromJson(result.data);
}

Future<String> updatePassword(
    {@required String password,
    @required String confirmPassword,
    @required String verifyToken}) async {
  final result = await ApiCall.generalApiCall(
      ApiRoutes.resetPassword, RequestMethod.create, body: {
    "password": password,
    "confirmPassword": confirmPassword,
    "token": verifyToken
  });

  print(result.data);

  return result.data['message'];
}
