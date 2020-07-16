import 'package:ecommerceapp/api_services/authentication_api_services.dart';
import 'package:ecommerceapp/config/decorations.dart';
import 'package:ecommerceapp/generated/l10n.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:ecommerceapp/utils/my_form_validators.dart';
import 'package:ecommerceapp/widgets/my_button.dart';
import 'package:ecommerceapp/widgets/my_snackbar.dart';
import 'package:flutter/material.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/14/2020 8:14 AM
///



class SignUpPage extends StatefulWidget {
  static final routeName = '/signUpPage';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  bool _autoValidate = false;
  String _password="", _confirmPassword="", firstName = "", lastName = "", email='';
  final _buttonKey = GlobalKey<MyButtonState>();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text(""),),
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: ListView(
          children: [
            SizedBox(height: height/10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                validator: (value){
                  firstName = value.trim();
                  return MyFormValidators.validateName(name: value.trim(),type: 1);
                },
                decoration: MyDecorations.authTextFieldDecoration().copyWith(hintText: S.of(context).firstName),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                validator: (value){
                  lastName = value.trim();
                  return MyFormValidators.validateName(name: value.trim(), type: 2);
                },
                decoration: MyDecorations.authTextFieldDecoration().copyWith(hintText: S.of(context).lastName),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: width/16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  email = value.trim();
                  return MyFormValidators.validateMail(value.trim());
                },
                decoration: MyDecorations.authTextFieldDecoration().copyWith(hintText: S.of(context).email),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding : EdgeInsets.symmetric(horizontal: width/16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                obscureText: _isVisible?false:true,
                validator: (value){
                  _password = value;
                  return MyFormValidators.validatePassword(password: _password, isConfirmPassword: false);
                },
                decoration: MyDecorations.authTextFieldDecoration().copyWith(
                  hintText: S.of(context).password,
                    suffixIcon: GestureDetector(
                      child: Icon(_isVisible?Icons.visibility:Icons.visibility_off, color: Colors.black12,),
                      onTap: (){
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                    )
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/16),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                obscureText: _isVisible?false:true,
                validator: (value){
                  _confirmPassword = value;
                  String errMsg = MyFormValidators.validatePassword(password: _confirmPassword, isConfirmPassword: true);
                  if(errMsg!=null){
                    return errMsg;
                  }else if(_password != _confirmPassword){
                    return "Both passwords must match";
                  }else{
                    return errMsg;
                  }
                },
                decoration: MyDecorations.authTextFieldDecoration().copyWith(
                  hintText: S.of(context).confirmPassword,
                    suffixIcon: GestureDetector(
                      child: Icon(_isVisible?Icons.visibility:Icons.visibility_off, color: Colors.black12,),
                      onTap: (){
                        setState(() {
                          _isVisible = !_isVisible ;
                        });
                      },
                    )
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: MyButton(
                key: _buttonKey,
                  child: Text("Sign up"),
                  onPressed: (){
                    if (_formKey.currentState.validate()) {
                      _autoValidate = false;
                      print("Form is Validated");
                      _buttonKey.currentState.showLoader();
                      signUpWithEmail(
                          email: email,
                          password: _password,
                          firstName: firstName,
                          lastName: lastName,
                          role: 1)
                          .then((value) {
                        _buttonKey.currentState.hideLoader();
                        onAuthenticationSuccess(value);
                      }).catchError((err) {
                        _buttonKey.currentState.hideLoader();
                        MySnackbar.show('Error', err.toString());
                      });
                    }else{
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
