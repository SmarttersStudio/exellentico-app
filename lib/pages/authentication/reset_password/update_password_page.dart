import 'package:ecommerceapp/api_services/reset_password_api_services.dart';
import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/pages/authentication/login/login_page.dart';
import 'package:ecommerceapp/utils/my_form_validators.dart';
import 'package:ecommerceapp/widgets/my_button.dart';
import 'package:ecommerceapp/widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/23/2020 8:13 AM
///

class UpdatePasswordPage extends StatefulWidget {
  static final routeName = '/updatePasswordPage';
  final String token;
  UpdatePasswordPage({this.token});

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}
class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  String _password="", _confirmPassword="";
  final GlobalKey<MyButtonState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text(MyStrings.updatePasswordPage),),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: height/3.7,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                obscureText: _isVisible?false:true,
                validator: (value){
                  _password = value;
                  return MyFormValidators.validatePassword(password: value );
                },
                decoration: MyDecorations.authTextFieldDecoration().copyWith(
                    hintText: "Password",
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
                obscureText: _isVisible ? false : true,
                validator: (value){
                  _confirmPassword = value;
                  String errMsg = MyFormValidators.validatePassword(password: value,isConfirmPassword: true);
                  if(errMsg!=null){
                    return errMsg;
                  }else if(_password != _confirmPassword){
                    return "Both passwords must match";
                  }else{
                    return errMsg;
                  }
                },
                decoration: MyDecorations.authTextFieldDecoration().copyWith(
                    hintText: "Confirm Password",
                    suffixIcon: GestureDetector(
                      child: Icon(_isVisible?Icons.visibility:Icons.visibility_off, color: Colors.black12),
                      onTap: (){
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                    )
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: MyButton(
                key: _key,
                  child: Text("Update Password"),
                  onPressed: (){
                    if (_formKey.currentState.validate()) {
                      print("Form is Validated");
                      _key.currentState.showLoader();
                      updatePassword(password: _password, confirmPassword: _confirmPassword,verifyToken: widget.token).then((value){
                        _key.currentState.hideLoader();
                        MySnackbar.show("Successful", value);
                        Future.delayed(Duration(milliseconds: 1000)).then((value){
                          Get.offAll(LoginPage());
                        });
                      }).catchError((err){
                        _key.currentState.hideLoader();
                        MySnackbar.show("ERROR", err.toString());
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
