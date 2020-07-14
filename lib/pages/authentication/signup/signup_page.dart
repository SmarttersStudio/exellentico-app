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
  String _password="", _confirmPassword="", firstName = "", lastName = "", email='', userName='';
  final _buttonKey = GlobalKey<MyButtonState>();
  bool _isUserNameLoading = false;
  bool _isUserNameError = false;
  bool _visibleUsernameMessage = false;
  bool _isUserNameEmpty = false;
  String _userNameErrorMsg = '';



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
            SizedBox(height: height/10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                validator: (value){
                  firstName = value;
                  return MyFormValidators.validateName(value);
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
                  lastName = value;
                  return MyFormValidators.validateName(value);
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
                  email = value;
                  return MyFormValidators.validateMail(value);
                },
                decoration: MyDecorations.authTextFieldDecoration().copyWith(hintText: S.of(context).email),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: width/16),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                      onChanged: (value)=>userName=value,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        userName = value;
                        return MyFormValidators.validateName(value);
                      },
                      decoration: MyDecorations.authTextFieldDecoration().copyWith(hintText: "User name"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: width/30),
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    onPressed: (){
                      if(userName.trim().isEmpty){
                        setState(() {
                          _visibleUsernameMessage = true;
                          _isUserNameEmpty = true;
                        });
                      }else{
                        setState(() {
                          _visibleUsernameMessage = false;
                          _isUserNameEmpty = false;
                          _isUserNameLoading = true;
                        });
                        verifyUserName(userName: userName.trim()).then((value){
                          if(value.result){
                            setState(() {
                              _visibleUsernameMessage = true;
                              _isUserNameEmpty = false;
                              _isUserNameLoading = false;
                              _isUserNameError = false;
                            });
                          }else{
                            setState(() {
                              _visibleUsernameMessage = true;
                              _isUserNameEmpty = false;
                              _isUserNameLoading = false;
                              _isUserNameError = true;
                              _userNameErrorMsg = value.message;
                            });
                          }
                        });
                      }
                    },
                    child: _isUserNameLoading ? SizedBox(height:20,width:20,child: CircularProgressIndicator())
                        : Text("Check", style: TextStyle(
                    ),),
                  ),
                )
              ],
            ),
            Visibility(
              visible: _visibleUsernameMessage,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 12, vertical: 4),
                child: Row(
                  children: [
                    _isUserNameError || _isUserNameEmpty ? Icon(
                      Icons.clear,
                      color: Colors.red,
                    ) : Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(_isUserNameError
                          ? _userNameErrorMsg
                          : _isUserNameEmpty ? 'Please enter username' : 'Username available', style: TextStyle(
                        fontSize: 12,
                          color: _isUserNameError || _isUserNameEmpty
                              ? Colors.red
                              : Colors.green
                      ),),
                    ),
                  ],
                ),
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
                  String errMsg = MyFormValidators.validatePassword(value);
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
                      print("Form is Validated");
                      _buttonKey.currentState.showLoader();
                      signUpWithEmail(
                          email: email,
                          password: _password,
                          firstName: firstName,
                          lastName: lastName,
                          userName: userName,
                          role: 1)
                          .then((value) {
                        _buttonKey.currentState.hideLoader();
                        onAuthenticationSuccess(value);
                      }).catchError((err) {
                        _buttonKey.currentState.hideLoader();
                        MySnackbar.show('Error', err.toString());
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
