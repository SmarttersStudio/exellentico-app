import 'dart:ffi';
import 'package:ecommerceapp/api_services/authentication_api_services.dart';
import 'package:ecommerceapp/config/social_sign_in_config.dart';
import 'package:ecommerceapp/pages/authentication/login/login_page.dart';
import 'package:ecommerceapp/pages/authentication/social_sign_in/select_user_name_page.dart';
import 'package:ecommerceapp/pages/demo_page.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:ecommerceapp/widgets/my_button.dart';
import 'package:ecommerceapp/widgets/my_snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 8:59 AM
///

class SocialSignInPage extends StatefulWidget {
  static final routeName = '/socialSignInPage';
  @override
  _SocialSignInPageState createState() => _SocialSignInPageState();
}

class _SocialSignInPageState extends State<SocialSignInPage> {

  bool _isSocialMediaButtonDisabled = false;
  bool _isGoogleLoading = false;
  bool _isFbLoading = false;
  final facebookLogin = FacebookLogin();
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: SignInWithGoogleConfig.clientId,
    scopes: ['email'],
  );


  Future<void> _signInFaceBook() async {
    setState(() {
      _isSocialMediaButtonDisabled = true;
      _isFbLoading = true;
    });
    var facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    final facebookLoginResult = await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        setState(() {
          _isSocialMediaButtonDisabled = false;
          _isFbLoading = false;
        });
        MySnackbar.show(
            'Error', FacebookLoginStatus.error.toString());
        print(FacebookLoginStatus.error.toString());
        throw FacebookLoginStatus.error.toString();
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          _isSocialMediaButtonDisabled = false;
          _isFbLoading = false;
        });
        throw FacebookLoginStatus.error.toString();
        break;
      case FacebookLoginStatus.loggedIn:
        final token = facebookLoginResult.accessToken.token;
        print(token);
        signInWithSocialMedia(socialToken: token, socialAuthType: 2)
            .then((value) {
          onAuthenticationSuccess(value);
        }).catchError((err) {
          if (err.toString() ==
              'BadRequest: Invalid UserName') {
            Get.to(SocialSignInUserNamePage(
              accessToken: token.trim(),
              authType: 2,
            ));
          } else {
            facebookLogin.logOut();
            MySnackbar.show('Error', err?.toString());
          }
          setState(() {
            _isSocialMediaButtonDisabled = false;
            _isFbLoading = false;
          });
          setState(() {
            _isSocialMediaButtonDisabled = false;
            _isFbLoading = false;
          });
        });
        await facebookLogin.logOut();
        return true;
        break;
    }
  }

  void _signInGoogle() {
    googleSignIn.signIn().then((result) {
      result.authHeaders.then((value) {
        print(value['Authorization']);
        String s = value['Authorization'];
        s = s.replaceAll('Bearer', '');
        print(s.trim());
        googleSignIn.signOut().then((value){
          setState(() {
            _isSocialMediaButtonDisabled = true;
            _isGoogleLoading = true;
          });
          signInWithSocialMedia(
              socialToken: s.trim(), socialAuthType: 1).then((value){
            onAuthenticationSuccess(value);
          }).catchError((onError){
            if(onError.toString() ==
                'BadRequest: Invalid UserName') {
              Get.to(SocialSignInUserNamePage(
                accessToken: s.trim(),
                authType: 1,
              ));
            } else {
              MySnackbar.show('Error', onError?.toString());
            }
            setState(() {
              _isSocialMediaButtonDisabled = false;
              _isGoogleLoading = false;
            });
          });
        });
      }).catchError((err) {
        setState(() {
          _isSocialMediaButtonDisabled = false;
          _isGoogleLoading = false;
        });
        googleSignIn.signOut();
        MySnackbar.show('Error', err.toString());
      });
    }).catchError((err) {
      print(err.toString());
      MySnackbar.show("ERROR", "Please try again later");
      setState(() {
        _isSocialMediaButtonDisabled = false;
        _isGoogleLoading = false;
      });
      googleSignIn.signOut();
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                child: Text("Sign In with Google"),
                onPressed: _isSocialMediaButtonDisabled? null : _signInGoogle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                child: Text("Sign In with Facebook"),
                onPressed: _isSocialMediaButtonDisabled? null : _signInFaceBook,
              ),
            ),
            SizedBox(height: height/12,),
            RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
                  text: "Already have an account ?",
                  children: [
                    TextSpan(
                        text: " Sign In",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight
                                .w500,
                            color: Colors.red),
                        recognizer: TapGestureRecognizer()..onTap = ()=>Get.to(LoginPage())
                    )
                  ]
              ),),
            MyButton(child: Text("test"), onPressed: ()=>Get.to(MyHomePage()),width: 200,)
          ],
        ),
      ),
    );
  }
}
