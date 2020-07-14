import 'dart:async';

import 'package:ecommerceapp/api_services/on_boarding_api_services.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/update_password_page.dart';
import 'package:ecommerceapp/widgets/my_button.dart';
import 'package:ecommerceapp/widgets/my_snackbar.dart';
import 'package:ecommerceapp/widgets/pin_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final GlobalKey<MyButtonState> _key = GlobalKey();
  String _otp='', _error='';
  bool _autoValidate = false;
  Timer _timer;
  int timerCounter = 59;


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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinView(
              focusedBorderColor: Colors.orange,
              onFocus: () {},
              onSubmit: (value) {
                setState(() {
                  pin = value;
                });
              },
              onDelete: () {
                setState(() {
                  pin = "";
                });
              },
            ),
            SizedBox(
              height: 42,
            ),
            MyButton(
              key: _key,
              width: width/3 ,
              child: Text("Verify"),
              onPressed: pin.isNotEmpty ? () {
                print(pin);
                _key.currentState.showLoader();
                verifyOTP(widget.phone, pin).then((value){
                  Get.to(UpdatePasswordPage());
                }).catchError((err){
                  MySnackbar.show("ERROR", err.toString());
                }).whenComplete(() => _key.currentState.hideLoader());
              }: null,
            ),

            Text(
              '00:${timerCounter < 10 ? timerCounter.toString().padLeft(2, '0') : timerCounter}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text("Haven't you receive any OTP yet ?"),
            FlatButton(
              padding: const EdgeInsets.all(0),
              onPressed: timerCounter == 0
                  ? () {
                setState(() {
                  timerCounter = 60;
//                  isLoading = true;
                });
                sendOtpToPhoneNumber(widget.phone).then((value) {
                  MySnackbar.show('Check your phone', value.toString());
                  startTimer();
                }).catchError((err) {
                  setState(() {
                    timerCounter = 0;
                  });
                  MySnackbar.show('Error', err.toString());
                }).whenComplete(() {
                  setState(() {
//                    isLoading = false;
                  });
                });
              }
                  : null,
              child: Text(
                "Resend",
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
