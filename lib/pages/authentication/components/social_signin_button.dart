import 'package:ecommerceapp/api_services/authentication_api_services.dart';
import 'package:ecommerceapp/config/colors.dart';
import 'package:ecommerceapp/config/social_sign_in_config.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:ecommerceapp/widgets/loader.dart';
import 'package:ecommerceapp/widgets/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
/// Created by Sunil Kumar on 17-07-2020 03:31 PM.
///

class GoogleSignInButton extends StatelessWidget {
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: SignInWithGoogleConfig.clientId,
    scopes: ['email'],
  );
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => _signInGoogle(context),
      constraints: BoxConstraints.tightFor(),
      shape: CircleBorder(),
      child: Ink(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Color(0xffFF355D)),
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/icons/google_logo.png',
          width: 28,
          height: 28,
        ),
      ),
    );
  }

  _signInGoogle(BuildContext context) async {
    try {
      Navigator.push(context, LoaderOverlay());
      final result = await googleSignIn.signIn();
      if (result != null) {
        await result.authHeaders.then((value) async {
          String s = value['Authorization'];
          s = s.replaceAll('Bearer', '');
          await googleSignIn.signOut().then((value) async {
            await signInWithSocialMedia(
                    socialToken: s.trim(), socialAuthType: 1)
                .then((value) {
              onAuthenticationSuccess(value);
            });
          });
        }).catchError((err) {
          Get.back();
          googleSignIn.signOut();
          ExellenticoSnackBar.show('Error', err.toString());
        });
      } else {
        print('User cancelled.');
        Get.back();
      }
    } catch (err) {
      googleSignIn.signOut();
      Get.back();
    }
  }
}

class FacebookSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => _signInFaceBook(context),
      constraints: BoxConstraints.tightFor(),
      shape: CircleBorder(),
      child: Ink(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: getDynamicGradient(context).colors.reversed.toList())),
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/icons/fb_logo.png',
          width: 28,
          height: 28,
        ),
      ),
    );
  }

  _signInFaceBook(BuildContext context) async {
    Navigator.push(context, LoaderOverlay());
    var facebookLogin = FacebookLogin();
    final facebookLoginResult = await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        ExellenticoSnackBar.show('Error', FacebookLoginStatus.error.toString());
        Get.back();
        break;
      case FacebookLoginStatus.cancelledByUser:
//        FacebookLoginStatus.error.toString();
        Get.back();
        break;
      case FacebookLoginStatus.loggedIn:
        final token = facebookLoginResult.accessToken.token;
        signInWithSocialMedia(socialToken: token, socialAuthType: 2)
            .then((value) {
          onAuthenticationSuccess(value);
        }).catchError((err) {
          Get.back();
          ExellenticoSnackBar.show('Error', err?.toString());
        });
        await facebookLogin.logOut();
        return true;
        break;
    }
  }
}
