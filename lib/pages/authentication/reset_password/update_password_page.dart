import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/utils/my_form_validators.dart';
import 'package:flutter/material.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/23/2020 8:13 AM
///

class UpdatePasswordPage extends StatefulWidget {
  static final routeName = '/updatePasswordPage';

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}
class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  String _password="", _confirmPassword="";

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
                  return MyFormValidators.validatePassword(value);
                },
                decoration: MyDecorations.textFieldDecoration().copyWith(
                    hintText: "Password",
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
                    hintText: "Confirm Password",
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
            Center(
              child: RaisedButton(
                  child: Text("Submit"),
                  onPressed: (){
                    if (_formKey.currentState.validate()) {
                      print("Form is Validated");
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
