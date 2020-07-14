
import 'package:ecommerceapp/pages/authentication/login/login_page.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/otp_page.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/reset_password_page.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/update_password_page.dart';
import 'package:ecommerceapp/pages/authentication/signup/signup_page.dart';
import 'package:ecommerceapp/pages/authentication/social_sign_in/social_sign_in_page.dart';
import 'package:ecommerceapp/pages/demo_page.dart';
///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/16/2020 6:23 AM
///



mixin MyPageRoutes{

    static final routes = {
      '/' : (context) => MyHomePage(),
      '/loginPage' : (context) => LoginPage(),
        '/signUpPage' : (context) => SignUpPage(),
        '/resetPasswordPage' : (context) => ResetPasswordPage(),
        '/OTPPage' : (context) => OTPPage(),
        '/updatePasswordPage' : (context) => UpdatePasswordPage(),
      '/socialSignInPage' : (context) => SocialSignInPage()
    };
}