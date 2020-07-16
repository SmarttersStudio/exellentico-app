import 'package:ecommerceapp/api_services/base_api.dart';
import 'package:ecommerceapp/config/api_routes.dart';
import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 10:56 AM
///

///Api Call to send the otp to given phone number
Future<String> sendOtpToPhoneNumber(String phone) async {
  String path = ApiRoutes.phoneVerify;
  var body = {"phone": phone};
  var result =
      await ApiCall.generalApiCall(path, RequestMethod.create, body: body);
  print(result.toString());
  return result.data['message'];
}

///Api call to verify the OTP provided by the user
Future<String> verifyOTP(String phone, String otp) async {
  String path = ApiRoutes.verifyOTP;
  var body = { "phone": phone, "otp": otp};
  var result =
      await ApiCall.generalApiCall(path, RequestMethod.create, body: body);
  print(result.toString());
  final user = SharedPreferenceHelper.user;
  user.user.phone = phone;
  SharedPreferenceHelper.storeUser(user: user);
  return result.data['message'];
}
