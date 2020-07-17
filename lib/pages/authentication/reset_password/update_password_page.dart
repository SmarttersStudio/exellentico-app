import 'package:ecommerceapp/api_services/reset_password_api_services.dart';
import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/pages/authentication/components/auth_scaffold.dart';
import 'package:ecommerceapp/pages/authentication/login/login_page.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:ecommerceapp/utils/my_form_validators.dart';
import 'package:ecommerceapp/widgets/button.dart';
import 'package:ecommerceapp/widgets/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/23/2020 8:13 AM
///

class UpdatePasswordPage extends StatefulWidget {
  static final routeName = '/updatePasswordPage';
  final String token;
  UpdatePasswordPage({this.token});

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false, _autoValidate = false;
  String _password, _confirmPassword;
  final GlobalKey<ExellenticoButtonState> _buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AuthScaffold(
      body: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 54),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Update password',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              onSaved: (v) => _password = v.trim(),
                              onChanged: (v) {
                                setState(() {
                                  _password = v.trim();
                                });
                              },
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (v) =>
                                  FocusScope.of(context).unfocus(),
                              validator: (v) {
                                if (v.trim().isEmpty) {
                                  return 'Password can\'t be empty.';
                                }
                                if (v.trim().length < 8) {
                                  return 'Password must be 8 or more characters long.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'New password',
                                  prefixIcon: Icon(Icons.mail_outline)),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              onSaved: (v) => _confirmPassword = v.trim(),
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (v) =>
                                  FocusScope.of(context).unfocus(),
                              validator: (v) {
                                if (_password != null &&
                                    v.trim() != _password) {
                                  return 'Passwords didn\'t match.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Confirm password',
                                  prefixIcon: Icon(Icons.mail_outline)),
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
                            child: Text('Change password'),
                            onPressed: () {
                              final state = _formKey.currentState;
                              if (!state.validate()) {
                                setState(() {
                                  _autoValidate = true;
                                });
                              } else {
                                state.save();
                                _buttonKey.currentState.showLoader();
                                updatePassword(
                                        password: _password,
                                        confirmPassword: _confirmPassword,
                                        verifyToken: widget.token)
                                    .then((value) {
                                  ExellenticoSnackBar.show(
                                      "Success", value.toString());
                                  Get.offAll(LoginPage());
                                }).catchError((err) {
                                  print(err.toString());
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
              )
            ],
          )),
    );
  }
}
