import 'dart:ffi';

import 'package:ecommerceapp/config/social_sign_in_config.dart';
import 'package:ecommerceapp/pages/authentication/login/login_page.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:ecommerceapp/widgets/my_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 8:59 AM
///

class SocialSignInPage extends StatefulWidget {
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



  void _signInFaceBook() {
    setState(() => _isSocialMediaButtonDisabled = true);
    AuthHelper.handleFacebookSignIn(context: context)
        .then((value) =>
        setState(() => _isSocialMediaButtonDisabled = false))
        .catchError(
            (err) => setState(() => _isSocialMediaButtonDisabled = false));
  }

  void _signInGoogle() {
    try {
      setState(() => _isSocialMediaButtonDisabled = true);
      AuthHelper.handleGoogleSignIn(
          googleSignInClient: googleSignIn, context: context)
          .then((value) =>
          setState(() => _isSocialMediaButtonDisabled = false))
          .catchError(
              (err) => setState(() => _isSocialMediaButtonDisabled = false));
    } catch (err) {
      setState(() => _isSocialMediaButtonDisabled = false);
    }
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

          ],
        ),
      ),
    );
  }
}
