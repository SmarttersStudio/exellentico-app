import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/utils/my_form_validators.dart';
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

    @override
    Widget build(BuildContext context) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        return Scaffold(
            appBar: AppBar(title: Text(MyStrings.resetPasswordPage),),
            body: Form(
                key: _formKey,
                child: ListView(
                    children: [
                        SizedBox(height: height/3.2,),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: width/16),
                          child: TextFormField(
                              validator: (value)=>MyFormValidators.validateMail(value),
                              decoration: MyDecorations.textFieldDecoration().copyWith(hintText: "Email Id"),
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
