import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/widgets/pin_view.dart';
import 'package:flutter/material.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/22/2020 2:11 PM
///


class OTPPage extends StatefulWidget {
    static final routeName = '/OTPPage';
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
    String pin = "" ;
  @override
  Widget build(BuildContext context) {
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
                  RaisedButton(
                      child: Text("Submit"),
                      onPressed: pin.isNotEmpty ? () => print(pin) : null,
                  )
              ],
          ),
        ),
    );
  }
}
