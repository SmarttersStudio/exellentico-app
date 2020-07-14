import 'package:ecommerceapp/api_services/authentication_api_services.dart';
import 'package:ecommerceapp/data_models/user.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_linkedin/linkedloginflutter.dart';
import 'package:flutter_twitter/flutter_twitter.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/29/2020 11:19 AM
///


class AuthHelper {

    /// Method to handle Social Sign In
    static void handleSocialSignIn({
        @required BuildContext context,
        @required String socialToken,
        @required int socialAuthType,
        bool isTwitter = false,
        String tokenSecret = ""
    }) {
        signInWithSocialMedia(socialAuthType: socialAuthType,
            socialToken: socialToken,
            isTwitter: isTwitter,
            tokenSecret: tokenSecret).then((value) {
//            onAuthenticationSuccess(context);
        }).catchError((err) {
            print("helper error");
            print(err.toString());
        });
    }

//    /// Method to handle Sign In using Email Id
//    static void handleSignInEmail({
//        @required BuildContext context,
//        @required String email,
//        @required String password
//    }){
//        signInWithEmail(email: email, password: password).then((value){
//            onAuthenticationSuccess(context);
//        }).catchError((err){
//            print(err.toString());
//        });
//    }

//    /// Method to handle Sign Up using Email id
//    static void handleSignUpEmail({
//        @required BuildContext context,
//        @required String email,
//        @required String password,
//        @required String firstName,
//        @required String lastName,
//        @required String phone,
//        int role = 5,
//        List<double> coordinates = const [0,0],
//        bool phoneVerified = false,
//        bool emailVerified = false
//
//    }){
//        signUpWithEmail(
//            email: email,
//            password: password,
//            firstName: firstName,
//            lastName: lastName,
//            phone: phone,
//            emailVerified: emailVerified,
//            phoneVerified: phoneVerified,
//            coordinates: coordinates,
//            role: role
//        ).then((value){
//            onAuthenticationSuccess(context);
//        }).catchError((err){
//            print(err.toString());
//        });
//    }

    static Future<bool> handleGoogleSignIn(
        {GoogleSignIn googleSignInClient, BuildContext context}) {
        googleSignInClient.signIn().then((result) {
            result.authHeaders.then((value) {
                print(value['Authorization']);
                String s = value['Authorization'];
                s = s.replaceAll('Bearer', '');
                print(s.trim());
                googleSignInClient.signOut();
                AuthHelper.handleSocialSignIn(
                    context: context, socialToken: s.trim(), socialAuthType: 3);
                return true;
            }).catchError((err) {
                googleSignInClient.signOut();
                print(err?.toString());
                throw err;
            });
        }).catchError((err) {
            print(err?.toString());
            googleSignInClient.signOut();
            throw err;
        });
        return Future.value(false);
    }

    static Future<bool> handleFacebookSignIn({BuildContext context}) async {
        var facebookLogin = FacebookLogin();
        final facebookLoginResult = await facebookLogin.logIn(['email']);
        switch (facebookLoginResult.status) {
            case FacebookLoginStatus.error:
                print(FacebookLoginStatus.error.toString());
                throw FacebookLoginStatus.error.toString();
                break;
            case FacebookLoginStatus.cancelledByUser:
                throw FacebookLoginStatus.error.toString();
                break;
            case FacebookLoginStatus.loggedIn:
                final token = facebookLoginResult.accessToken.token.trim();
                AuthHelper.handleSocialSignIn(
                    context: context, socialToken: token, socialAuthType: 4);
                    await facebookLogin.logOut();
                return true;
                break;
        }
        return Future.value(false);
    }
}

void onAuthenticationSuccess(UserResponse user){
    SharedPreferenceHelper.storeUser(user: user);
    print("Authentication Successful");
    print("token : "+SharedPreferenceHelper.accessToken);
    print("first name : "+SharedPreferenceHelper.user.user.firstName);
    print("user name : "+SharedPreferenceHelper.user.user.userName);

}

