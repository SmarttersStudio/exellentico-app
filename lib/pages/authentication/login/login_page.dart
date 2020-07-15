import 'package:ecommerceapp/api_services/authentication_api_services.dart';
import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/generated/l10n.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/reset_password_page.dart';
import 'package:ecommerceapp/pages/authentication/signup/signup_page.dart';
import 'package:ecommerceapp/utils/my_form_validators.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:ecommerceapp/widgets/my_button.dart';
import 'package:ecommerceapp/widgets/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/14/2020 3:42 AM
///


class LoginPage extends StatefulWidget {
    static final routeName = '/loginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    final _buttonKey = GlobalKey<MyButtonState>();
    final _formKey = GlobalKey<FormState>();
    FocusNode _mailIdFocusNode;
    bool _isVisible = false;
    String emailId = "",
        password = "";


    @override
    void initState() {
        super.initState();
    }



    @override
    Widget build(BuildContext context) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        return Scaffold(
            appBar: AppBar(title: Text(S.of(context).loginAppBar),),
            body: Form(
                key: _formKey,
                child: ListView(
                    children: [
                        SizedBox(height: height/3.9,),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width / 16),
                            child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                focusNode: _mailIdFocusNode,
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                    emailId = value.trim();
                                    return MyFormValidators.validateMail(
                                        value.trim());
                                },
                                decoration: MyDecorations.authTextFieldDecoration()
                                    .copyWith(hintText: S
                                    .of(context)
                                    .email),
                            ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width / 16),
                            child: TextFormField(
                                textInputAction: TextInputAction.done,
                                obscureText: _isVisible ? false : true,
                                validator: (value) {
                                    password = value.trim();
                                    return MyFormValidators.validatePassword(password: value.trim());
                                },
                                decoration: MyDecorations.authTextFieldDecoration()
                                    .copyWith(
                                    hintText: S
                                        .of(context)
                                        .password,
                                    suffixIcon: IconButton(
                                        icon: Icon(_isVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off, color: Colors.black12,),
                                        onPressed: () {
                                            setState(() {
                                                _isVisible = !_isVisible;
                                            });
                                        })
                                ),
                            ),
                        ),
                        SizedBox(height: 40,),
                        Center(
                            child: MyButton(
                                key: _buttonKey,
                                child: Text(S
                                    .of(context)
                                    .loginButton),
                                onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                        print("Form is Validated");
                                        _buttonKey.currentState.showLoader();
                                        signInWithEmail(email: emailId, password: password).then((value){
                                            _buttonKey.currentState.hideLoader();
                                            onAuthenticationSuccess(value);
                                        }).catchError((err){
                                            print(err.toString());
                                            MySnackbar.show("ERROR", err.toString());
                                            _buttonKey.currentState.hideLoader();
                                        });
                                    }
                                }
                            ),
                        ),
                        SizedBox(height: height/12,),
                        Center(child: InkWell(
                            onTap: ()=>Get.to(ResetPasswordPage()),
                          child: Text("Forgot your password ?", style: TextStyle(
                              color: Colors.black.withOpacity(0.8)
                          ),),
                        )),
                        SizedBox(height: height/12,),
                        Center(
                          child: RichText(
                              text: TextSpan(
                                  style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
                                  text: "Don't have an account ?",
                                  children: [
                                      TextSpan(
                                          text: " Sign Up",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight
                                                  .w500,
                                              color: Colors.red),
                                          recognizer: TapGestureRecognizer()..onTap = ()=>Get.to(SignUpPage())
                                      )
                                  ]
                              ),),
                        ),

                    ],
                ),
            ),
        );
    }
}
