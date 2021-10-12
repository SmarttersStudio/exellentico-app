import 'package:ecommerceapp/data_models/user.dart';
import 'package:ecommerceapp/pages/authentication/login/login_page.dart';
import 'package:ecommerceapp/pages/authentication/verify_phone/verify_phone_page.dart';
import 'package:ecommerceapp/pages/dashboard/dashboard_page.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:get/get.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/29/2020 11:19 AM
///

void onAuthenticationSuccess(UserResponse user) {
  SharedPreferenceHelper.storeUser(user: user);
  checkLevel();
}

void checkLevel() {
  String token = SharedPreferenceHelper.accessToken;
  UserResponse? user = SharedPreferenceHelper.user;

  if (token == null)
    Get.offAll(LoginPage());
  else if (user!.user!.phone.isEmpty)
    Get.offAll(VerifyPhonePage());
  else
    Get.offAll(DashboardPage());
}
