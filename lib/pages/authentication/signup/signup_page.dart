import 'package:ecommerceapp/config/decorations.dart';
import 'package:ecommerceapp/generated/l10n.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:ecommerceapp/utils/my_form_validators.dart';
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
  String _password="", _confirmPassword="", firstName = "", lastName = "", email, phone;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text(""),),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: height/7,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                validator: (value){
                  firstName = value;
                  return MyFormValidators.validateName(value);
                },
                decoration: MyDecorations.textFieldDecoration().copyWith(hintText: S.of(context).firstName),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                validator: (value){
                  lastName = value;
                  return MyFormValidators.validateName(value);
                },
                decoration: MyDecorations.textFieldDecoration().copyWith(hintText: S.of(context).lastName),
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
                  email = value;
                  return MyFormValidators.validateMail(value);
                },
                decoration: MyDecorations.textFieldDecoration().copyWith(hintText: S.of(context).email),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                keyboardType: TextInputType.phone,
                validator: (value){
                  phone = value;
                  return MyFormValidators.validatePhone(value);
                },
                decoration: MyDecorations.textFieldDecoration().copyWith(hintText: S.of(context).phone),
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
                  return MyFormValidators.validatePassword(value);
                },
                decoration: MyDecorations.textFieldDecoration().copyWith(
                  hintText: S.of(context).password,
                    suffixIcon: GestureDetector(
                      child: Icon(_isVisible?Icons.visibility:Icons.visibility_off),
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
                  String errMsg = MyFormValidators.validatePassword(value);
                  if(errMsg!=null){
                    return errMsg;
                  }else if(_password != _confirmPassword){
                    return "Both passwords must match";
                  }else{
                    return errMsg;
                  }
                },
                decoration: MyDecorations.textFieldDecoration().copyWith(
                  hintText: S.of(context).confirmPassword,
                    suffixIcon: GestureDetector(
                      child: Icon(_isVisible?Icons.visibility:Icons.visibility_off),
                      onTap: (){
                        setState(() {
                          _isVisible = !_isVisible ;
                        });
                      },
                    )
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: RaisedButton(
                  child: Text(S.of(context).loginButton),
                  onPressed: (){
                    if (_formKey.currentState.validate()) {
                      print("Form is Validated");
                      AuthHelper.handleSignUpEmail(context: context,email: email, password: _password, firstName: firstName, lastName: lastName, phone: phone);
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
