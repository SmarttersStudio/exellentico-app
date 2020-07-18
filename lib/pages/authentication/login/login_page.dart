import 'package:ecommerceapp/api_services/authentication_api_services.dart';
import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/generated/l10n.dart';
import 'package:ecommerceapp/pages/authentication/components/auth_scaffold.dart';
import 'package:ecommerceapp/pages/authentication/components/social_signin_button.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/reset_password_page.dart';
import 'package:ecommerceapp/pages/authentication/signup/signup_page.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:ecommerceapp/widgets/button.dart';
import 'package:ecommerceapp/widgets/snackbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/14/2020 3:42 AM
///

class LoginPage extends StatefulWidget {
  static final routeName = '/loginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _buttonKey = GlobalKey<ExellenticoButtonState>();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true, _autoValidate = false;
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AuthScaffold(
      body: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  elevation: 24,
                  shadowColor:
                      Color.lerp(colorScheme.surface, Colors.black12, 0.1),
                  child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 34),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (v) => _email = v.trim(),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (v) =>
                                FocusScope.of(context).nextFocus(),
                            validator: (v) {
                              if (v.trim().isEmpty) {
                                return '*required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.mail_outline)),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (v) => _password = v.trim(),
                            onFieldSubmitted: (v) =>
                                FocusScope.of(context).unfocus(),
                            validator: (v) {
                              if (v.trim().isEmpty) {
                                return '*required';
                              }
                              return null;
                            },
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  child: Icon(_isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                )),
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              textColor: colorScheme.primary,
                              onPressed: () => Get.to(ResetPasswordPage()),
                              child: Text(
                                'Forgot password?',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -24,
                  left: 0,
                  right: 0,
                  child: Center(
                      child: ExellenticoButton(
                          width: 240,
                          key: _buttonKey,
                          child: Text(S.of(context).loginButton),
                          onPressed: () {
                            final state = _formKey.currentState;
                            if (!state.validate()) {
                              setState(() {
                                _autoValidate = true;
                              });
                            } else {
                              state.save();
                              _buttonKey.currentState.showLoader();
                              signInWithEmail(
                                email: _email,
                                password: _password,
                              ).then((value) {
                                onAuthenticationSuccess(value);
                              }).catchError((err, s) {
                                print(s);

                                ExellenticoSnackBar.show(
                                    "ERROR", err.toString());
                              }).then((value) {
                                _buttonKey.currentState.hideLoader();
                              });
                            }
                          })),
                ),
              ],
            ),
            SizedBox(
              height: 54,
            ),
            Row(
              children: [
                SizedBox(
                  width: 32,
                ),
                Expanded(
                  child: Divider(color: Colors.black45),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'Social Login',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Divider(color: Colors.black45),
                ),
                SizedBox(
                  width: 32,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleSignInButton(),
                SizedBox(
                  width: 16,
                ),
                FacebookSignInButton()
              ],
            ),
            SizedBox(height: 18),
            Center(
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.8)),
                    text: "Don't have an account ?",
                    children: [
                      TextSpan(
                          text: " Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(SignUpPage()))
                    ]),
              ),
            ),
            SizedBox(height: 54),
          ],
        ),
      ),
    );
  }
}
