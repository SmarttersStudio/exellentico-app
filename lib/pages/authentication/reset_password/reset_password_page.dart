import 'package:ecommerceapp/api_services/reset_password_api_services.dart';
import 'package:ecommerceapp/pages/authentication/components/auth_scaffold.dart';
import 'package:ecommerceapp/pages/authentication/login/login_page.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/otp_page.dart';
import 'package:ecommerceapp/widgets/button.dart';
import 'package:ecommerceapp/widgets/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/14/2020 8:14 AM
///

class ResetPasswordPage extends StatefulWidget {
  static final routeName = '/resetPasswordPage';
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _buttonKey = GlobalKey<ExellenticoButtonState>();
  bool _autoValidate = false;
  String _emailId;

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
                            'Forgot password',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (v) => _emailId = v.trim(),
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (v) =>
                                FocusScope.of(context).unfocus(),
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
                          child: Text('Send OTP'),
                          onPressed: () {
                            final state = _formKey.currentState;
                            if (!state.validate()) {
                              setState(() {
                                _autoValidate = true;
                              });
                            } else {
                              state.save();
                              _buttonKey.currentState.showLoader();
                              sendPasswordResetEmail(email: _emailId)
                                  .then((value) {
                                Get.to(OTPPage(
                                  email: _emailId,
                                ));
                              }).catchError((err) {
                                ExellenticoSnackBar.show(
                                    "ERROR", err.toString());
                              }).whenComplete(() {
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
            GestureDetector(
              child: Text('Back to login.',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: colorScheme.primary)),
              onTap: () => Get.offAll(LoginPage()),
            ),
          ],
        ),
      ),
    );
  }
}
