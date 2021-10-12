import 'package:ecommerceapp/api_services/on_boarding_api_services.dart';
import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/pages/onboarding/verify_phone/phone_otp_page.dart';
import 'package:ecommerceapp/utils/my_form_validators.dart';
import 'package:ecommerceapp/widgets/button.dart';
import 'package:ecommerceapp/widgets/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 10:02 AM
///

class VerifyPhonePage extends StatefulWidget {
  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  final _buttonKey = GlobalKey<ExellenticoButtonState>();
  String _phone = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Phone"),
      ),
      body: Form(
        autovalidate: _autoValidate,
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: height / 3.2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 16),
              child: TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                onChanged: (value) => _phone = value,
                validator: (value) {
                  _phone = value!;
                  return MyFormValidators.validatePhone(value);
                },
                decoration: Decorations.authTextFieldDecoration()
                    .copyWith(hintText: "Phone", icon: Text("+91")),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ExellenticoButton(
                  key: _buttonKey,
                  child: Text("Proceed"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Form is Validated");
                      _buttonKey.currentState?.showLoader();
                      sendOtpToPhoneNumber(_phone).then((value) {
                        ExellenticoSnackBar.show("Check your phone", "");
                        Get.to(VerifyPhoneOTPPage(
                          phone: _phone,
                        ));
                      }).catchError((err) {
                        ExellenticoSnackBar.show("ERROR", err.toString());
                      }).whenComplete(
                          () => _buttonKey.currentState?.hideLoader());
                    } else {
                      setState(() => _autoValidate = true);
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
