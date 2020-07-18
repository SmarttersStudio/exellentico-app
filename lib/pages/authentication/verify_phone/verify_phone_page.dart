import 'package:ecommerceapp/api_services/on_boarding_api_services.dart';
import 'package:ecommerceapp/generated/l10n.dart';
import 'package:ecommerceapp/pages/authentication/components/auth_scaffold.dart';
import 'package:ecommerceapp/pages/authentication/verify_phone/phone_otp_page.dart';
import 'package:ecommerceapp/widgets/button.dart';
import 'package:ecommerceapp/widgets/snackbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

///
/// Created by Sunil Kumar on 06-07-2020 10:51 AM.
///
class VerifyPhonePage extends StatefulWidget {
  static final routeName = '/verifyPhone';

  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _phone;
  bool _autoValidate = false;
  final _buttonKey = GlobalKey<ExellenticoButtonState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AuthScaffold(
      body: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.transparent,
          body: Center(
            child: Stack(
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
                            S.of(context).verifyYourPhoneNumber,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            onSaved: (v) {
                              _phone = v.trim();
                            },
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).unfocus();
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                            decoration: InputDecoration(
                                icon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/icons/indian_flag.png',
                                      height: 22,
                                      width: 22,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text("+91"),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Container(
                                      height: 24,
                                      width: 0.7,
                                      color: colorScheme.brightness ==
                                              Brightness.light
                                          ? Colors.black54
                                          : Colors.white54,
                                    ),
                                  ],
                                ),
                                hintText: S.of(context).enterYourPhoneNumber,
                                contentPadding: const EdgeInsets.all(0)),
                            validator: (str) {
                              if (str.trim().isEmpty)
                                return S.of(context).required;
                              else if (str.trim().length != 10)
                                return S.of(context).invalidPhoneNumber;
                              return null;
                            },
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
                          child: Text('Send OTP'),
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
                              sendOtpToPhoneNumber(_phone).then((value) {
                                ExellenticoSnackBar.show(
                                    'Check your phone', value.toString());
                                Get.to(PhoneOtpPage(phone: _phone));
                              }).catchError((err, s) {
                                ExellenticoSnackBar.show(
                                    'Error', err.toString());
                              }).whenComplete(() {
                                _buttonKey.currentState.hideLoader();
                              });
                            }
                          })),
                ),
              ],
            ),
          )),
    );
  }
}
