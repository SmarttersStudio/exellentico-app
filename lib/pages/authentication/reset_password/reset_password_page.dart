import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/utils/my_form_validators.dart';
import 'package:ecommerceapp/widgets/my_button.dart';
import 'package:flutter/material.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/14/2020 8:14 AM
///





class ResetPasswordPage extends StatefulWidget {
    static final routeName = '/resetPasswordPage';
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

    final _formKey = GlobalKey<FormState>();
    final _buttonKey = GlobalKey<MyButtonState>();
    bool _autoValidate = false;
    String _emailId = '';


    @override
    Widget build(BuildContext context) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        return Scaffold(
            appBar: AppBar(title: Text(MyStrings.resetPasswordPage),),
            body: Form(
              autovalidate: _autoValidate,
                key: _formKey,
                child: ListView(
                    children: [
                        SizedBox(height: height/3.2,),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: width/16),
                          child: TextFormField(
                            onChanged: (value)=>_emailId = value,
                              validator: (value){
                                _emailId = value;
                                return MyFormValidators.validateMail(value);
                              },
                              decoration: MyDecorations.authTextFieldDecoration().copyWith(hintText: "Email Id"),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Center(
                          child: MyButton(
                            key: _buttonKey,
                              child: Text("Submit"),
                              onPressed: (){
                                  if (_formKey.currentState.validate()) {
                                      print("Form is Validated");

                                  }else{
                                    setState(() => _autoValidate = true);
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
