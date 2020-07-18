import 'package:ecommerceapp/api_services/base_api.dart';
import 'package:ecommerceapp/config/api_routes.dart';
import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 10:56 AM
///

///Api Call to send the otp to given phone number
Future<String> sendOtpToPhoneNumber(String phone) async {
  final String path = ApiRoutes.phoneVerify;
  final String userId = SharedPreferenceHelper.user.user.id;
  final body = {"user": userId, "phone": phone};
  final result =
      await ApiCall.generalApiCall(path, RequestMethod.create, body: body);
  return result.data['message'];
}

///Api call to verify the OTP provided by the user
Future<String> verifyOTP(String phone, String otp) async {
  String path = ApiRoutes.verifyOTP;
  String userId = SharedPreferenceHelper.user.user.id;
  final body = {"user": userId, "phone": phone, "otp": otp};
  final result =
      await ApiCall.generalApiCall(path, RequestMethod.create, body: body);
  final user = SharedPreferenceHelper.user;
  user.user.phone = phone;
  SharedPreferenceHelper.storeUser(user: user);
  return result.data['message'];
}
