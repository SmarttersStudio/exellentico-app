import 'dart:async';
import 'package:ecommerceapp/api_services/on_boarding_api_services.dart';
import 'package:ecommerceapp/widgets/button.dart';
import 'package:ecommerceapp/widgets/pin_textfield.dart';
import 'package:ecommerceapp/widgets/snackbar_helper.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 10:03 AM
///

class VerifyPhoneOTPPage extends StatefulWidget {
  final String phone;
  VerifyPhoneOTPPage({this.phone});

  @override
  _VerifyPhoneOTPPageState createState() => _VerifyPhoneOTPPageState();
}

class _VerifyPhoneOTPPageState extends State<VerifyPhoneOTPPage> {
  String pin = "";
  final GlobalKey<ExellenticoButtonState> _key = GlobalKey();
  String _otp = '', _error = '';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinCodeTextField(
              length: 4,
              textInputType: TextInputType.number,
              textStyle: TextStyle(color: Colors.white, fontSize: 22),
              enableEmptyColor: colorScheme.brightness == Brightness.light
                  ? Color(0xfff0f0f0)
                  : null,
              autoFocus: true,
              onChanged: (val) {
                _otp = val.trim();
              },
              onCompleted: (val) {
                verifyOTP(widget.phone, _otp).then((value) {
                  ExellenticoSnackBar.show(
                      'OTP Verification Successful', value.toString());
//                  Get.to(SelectBoardPage());
                }).catchError((err) {
                  ExellenticoSnackBar.show('Error', err.toString());
                });
              },
            ),
            SizedBox(
              height: 42,
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                '00:${timerCounter < 10 ? timerCounter.toString().padLeft(2, '0') : timerCounter}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              "Haven't you receive any OTP yet ?",
              style: TextStyle(color: Colors.black.withOpacity(0.8)),
            ),
            FlatButton(
              padding: const EdgeInsets.all(0),
              onPressed: timerCounter == 0
                  ? () {
                      setState(() {
                        timerCounter = 60;
                        isLoading = true;
                      });
                      sendOtpToPhoneNumber(widget.phone).then((value) {
                        ExellenticoSnackBar.show(
                            'Check your phone', value.toString());
                        startTimer();
                      }).catchError((err) {
                        setState(() {
                          timerCounter = 0;
                        });
                        ExellenticoSnackBar.show('Error', err.toString());
                      }).whenComplete(() {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    }
                  : null,
              child: isLoading
                  ? SizedBox(
                      height: 20, width: 20, child: CircularProgressIndicator())
                  : Text(
                      "Resend",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: timerCounter == 0
                              ? Colors.red
                              : Colors.black.withOpacity(0.7)),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
