import 'dart:async';

import 'package:ecommerceapp/api_services/reset_password_api_services.dart';
import 'package:ecommerceapp/pages/authentication/components/auth_scaffold.dart';
import 'package:ecommerceapp/pages/authentication/login/login_page.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/update_password_page.dart';
import 'package:ecommerceapp/widgets/pin_textfield.dart';
import 'package:ecommerceapp/widgets/progress_indicator.dart';
import 'package:ecommerceapp/widgets/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/22/2020 2:11 PM
///

class OTPPage extends StatefulWidget {
  static final routeName = '/OTPPage';
  final String email;
  OTPPage({this.email});
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _formKey = GlobalKey<FormState>();
  String _otp, _error;
  bool _autoValidate = false;
  Timer _timer;
  int timerCounter = 59;
  bool isLoading = false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(
          () {
            if (timerCounter < 1) {
              timer.cancel();
            } else {
              timerCounter = timerCounter - 1;
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AuthScaffold(
      body: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 22),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter OTP',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 16),
                          Center(
                            child: Text(
                              'Enter OTP that we sent to ${widget.email}',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 16),
                          Center(
                            child: PinCodeTextField(
                              length: 4,
                              textInputType: TextInputType.number,
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 22),
                              enableEmptyColor:
                                  colorScheme.brightness == Brightness.light
                                      ? Color(0xfff0f0f0)
                                      : Colors.white54,
                              autoFocus: true,
                              onChanged: (val) {
                                _otp = val.trim();
                              },
                              onCompleted: (val) {
                                setState(() => isLoading = true);
                                verifyOtpForPasswordReset(
                                        pin: int.parse(val.trim()),
                                        email: widget.email)
                                    .then((value) {
                                  setState(() => isLoading = false);
                                  if (value.accessToken.isNotEmpty) {
                                    Get.to(UpdatePasswordPage(
                                        token: value.accessToken));
                                  } else {
                                    ExellenticoSnackBar.show(
                                        'Error', 'Invalid OTP');
                                  }
                                }).catchError((err) {
                                  setState(() => isLoading = false);
                                  ExellenticoSnackBar.show('Error', '$err');
                                });
                              },
                            ),
                          ),
                          Center(
                            child: Text(
                              '00:${timerCounter < 10 ? timerCounter.toString().padLeft(2, '0') : timerCounter}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.primary),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Didn\'t you received any code?',
                                style: TextStyle(color: colorScheme.onSurface),
                              ),
                              FlatButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: timerCounter == 0
                                    ? () {
                                        setState(() {
                                          timerCounter = 60;
//                                            isLoading = true;
                                        });
//              sendPhoneVerification(
//                  context, widget.phone.trim())
//                  .then((String value) {
//                Toast.show(value);
                                        startTimer();
//              }).catchError((error, s) {
//                print(s);
//                setState(() {
//                  timerCounter = 0;
//                });
//                Toast.show(error.toString());
//              }).whenComplete(() {
//                setState(() {
//                  isLoading = false;
//                });
//              });
                                      }
                                    : null,
                                child: Text(
                                  'Resend',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                textColor: colorScheme.primary,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 34,
            ),
            if (isLoading) ExellenticoProgress(),
            SizedBox(
              height: 16,
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
