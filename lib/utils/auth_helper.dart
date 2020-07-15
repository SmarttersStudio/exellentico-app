import 'package:ecommerceapp/data_models/user.dart';
import 'package:ecommerceapp/pages/authentication/social_sign_in/social_sign_in_page.dart';
import 'package:ecommerceapp/pages/dashboard/dashboard_page.dart';
import 'package:ecommerceapp/pages/onboarding/verify_phone/verify_phone_page.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:get/get.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/29/2020 11:19 AM
///


void onAuthenticationSuccess(UserResponse user){
    SharedPreferenceHelper.storeUser(user: user);
    print("Authentication Successful");
    print("token : "+SharedPreferenceHelper.accessToken);
    print("first name : "+SharedPreferenceHelper.user.user.firstName);
    print("user name : "+SharedPreferenceHelper.user.user.userName);
    checkLevel();
}


void checkLevel() {
    UserResponse user = SharedPreferenceHelper.user;
    if(user == null )
        Get.offAll(SocialSignInPage());
    else if (user.user.phone.isEmpty)
        Get.offAll(VerifyPhonePage());
    else
        Get.offAll(DashboardPage());
}
