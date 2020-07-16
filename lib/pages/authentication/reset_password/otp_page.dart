import 'dart:async';

import 'package:ecommerceapp/api_services/reset_password_api_services.dart';
import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/update_password_page.dart';
import 'package:ecommerceapp/widgets/my_button.dart';
import 'package:ecommerceapp/widgets/my_snackbar.dart';
import 'package:ecommerceapp/widgets/pin_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/22/2020 2:11 PM
///


class OTPPage extends StatefulWidget {
    static final routeName = '/OTPPage';
    final String email ;
    OTPPage({this.email});
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
    String pin = "" ;
    final GlobalKey<MyButtonState> _key = GlobalKey();
    String _otp='', _error='';
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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: Text(MyStrings.otpPage),),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  PinView(
                      focusedBorderColor: Colors.orange,
                      onFocus: (){},
                      onSubmit: (value){
                          setState(() {
                              pin = value;
                          });
                      },
                      onDelete: (){
                          setState(() {
                            pin = "" ;
                          });
                      },
                  ),
                  SizedBox(height: 12,),
                  MyButton(
                    key: _key,
                    width: width/3,
                      child: Text("Verify"),
                      onPressed: pin.isNotEmpty ? (){
                        print(pin);
                        _key.currentState.showLoader();
                        verifyOtpForPasswordReset(email: widget.email, pin: int.parse(pin)).then((value){
                          _key.currentState.hideLoader();
                          Get.offAll(UpdatePasswordPage(token: value.accessToken,));
                        }).catchError((err){
                          _key.currentState.hideLoader();
                          MySnackbar.show("ERROR", err.toString());
                        });

                      } : null,
                  ),

                Padding(
                  padding: EdgeInsets.all(width/20),
                  child: Text(
                    '00:${timerCounter < 10 ? timerCounter.toString().padLeft(2, '0') : timerCounter}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),

                Text("Haven't you receive any OTP yet ?", style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                FlatButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: timerCounter == 0
                      ? () {
                    setState(() {
                      timerCounter = 60;
                      isLoading = true;
                    });
                    sendPasswordResetEmail(email: widget.email).then((value) {
                      MySnackbar.show('Check your email', value.toString());
                      startTimer();
                    }).catchError((err) {
                      setState(() {
                        timerCounter = 0;
                      });
                      MySnackbar.show('Error', err.toString());
                    }).whenComplete(() {
                      setState(() {
                        isLoading = false;
                      });
                    });
                  }
                      : null,
                  child: isLoading
                      ? SizedBox(height:20,width:20,child: CircularProgressIndicator())
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
