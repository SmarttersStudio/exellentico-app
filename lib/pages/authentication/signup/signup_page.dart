import 'package:ecommerceapp/api_services/authentication_api_services.dart';
import 'package:ecommerceapp/config/colors.dart';
import 'package:ecommerceapp/generated/l10n.dart';
import 'package:ecommerceapp/pages/authentication/components/auth_scaffold.dart';
import 'package:ecommerceapp/pages/authentication/components/social_signin_button.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:ecommerceapp/widgets/button.dart';
import 'package:ecommerceapp/widgets/snackbar_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/14/2020 8:14 AM
///

class SignUpPage extends StatefulWidget {
  static final routeName = '/signUpPage';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obSecure = true;
  bool _autoValidate = false;
  String _password, _confirmPassword, _firstName, _lastName, _email;
  final _buttonKey = GlobalKey<ExellenticoButtonState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AuthScaffold(
      body: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 5),
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
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 44),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              onSaved: (v) => _firstName = v.trim(),
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
                                  labelText: 'First name',
                                  prefixIcon: Icon(Icons.person_outline)),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              onSaved: (v) => _lastName = v.trim(),
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
                                  labelText: 'Last name',
                                  prefixIcon: Icon(Icons.person_outline)),
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
                                if (!v.trim().isEmail) {
                                  return 'Invalid email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.mail_outline)),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              onSaved: (v) => _password = v.trim(),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (v) =>
                                  FocusScope.of(context).nextFocus(),
                              validator: (v) {
                                if (v.trim().isEmpty) {
                                  return '*required';
                                }
                                if (v.trim().length < 8) {
                                  return 'Password must be 8 or more characters long.';
                                }
                                return null;
                              },
                              obscureText: _obSecure,
                              onChanged: (v) {
                                setState(() {
                                  _password = v.trim();
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock_outline),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obSecure = !_obSecure;
                                      });
                                    },
                                    child: Icon(_obSecure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  )),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              onSaved: (v) => _confirmPassword = v.trim(),
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (v) =>
                                  FocusScope.of(context).unfocus(),
                              validator: (v) {
                                if (v.trim() != _password.trim()) {
                                  return 'Passwords didn\'t match.';
                                }
                                return null;
                              },
                              obscureText: _obSecure,
                              decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icon(Icons.lock_outline),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obSecure = !_obSecure;
                                      });
                                    },
                                    child: Icon(_obSecure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  )),
                            ),
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
                            FocusScope.of(context).unfocus();

                            final state = _formKey.currentState;
                            if (!state.validate()) {
                              setState(() {
                                _autoValidate = true;
                              });
                            } else {
                              state.save();
                              _buttonKey.currentState.showLoader();
                              signUpWithEmail(
                                      email: _email,
                                      password: _confirmPassword,
                                      firstName: _firstName,
                                      lastName: _lastName)
                                  .then((value) {
                                onAuthenticationSuccess(value);
                              }).catchError((err, s) {
                                print(s);
                                ExellenticoSnackBar.show(
                                    "ERROR", err.toString());
                              }).then((value) {
                                _buttonKey.currentState.hideLoader();
                              });
                            }
                          }),
                    ),
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
                      text: "Already have an account ?",
                      children: [
                        TextSpan(
                            text: " Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: colorScheme.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back())
                      ]),
                ),
              ),
              SizedBox(height: 54),
            ],
          ),
        ),
      ),
    );
  }
}
