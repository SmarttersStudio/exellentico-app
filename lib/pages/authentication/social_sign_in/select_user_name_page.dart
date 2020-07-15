import 'package:ecommerceapp/api_services/authentication_api_services.dart';
import 'package:ecommerceapp/config/decorations.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:ecommerceapp/utils/my_form_validators.dart';
import 'package:ecommerceapp/widgets/my_button.dart';
import 'package:ecommerceapp/widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 9:02 AM
///


class SocialSignInUserNamePage extends StatefulWidget {
  final String accessToken;
  final int authType;

  SocialSignInUserNamePage(
      {@required this.accessToken, @required this.authType});

  @override
  _SocialSignInUserNamePageState createState() => _SocialSignInUserNamePageState();
}

class _SocialSignInUserNamePageState extends State<SocialSignInUserNamePage> {
  final _formKey = GlobalKey<FormState>();
  final _buttonKey = GlobalKey<MyButtonState>();
  bool _autoValidate = false;
  String userName = '';
  bool _isUserNameLoading = false;
  bool _isUserNameError = false;
  bool _visibleUsernameMessage = false;
  bool _isUserNameEmpty = false;
  String _userNameErrorMsg = '';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    final ColorScheme colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width / 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Enter user name",
                  style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Please Enter a user name and verify to continue",
                  style: TextStyle(
                      color: colorScheme.onPrimary
                          .withOpacity(0.87),
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (str) => userName = str,
                        validator: (value) {
                          userName = value;
                          return MyFormValidators.validateName(name: value, type: 3);
                        },
                        decoration: MyDecorations.authTextFieldDecoration().copyWith(
                            hintText: "User name"
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
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
                        child: _isUserNameLoading ? CircularProgressIndicator()
                            : Text("Check", style: TextStyle(
                            color: colorScheme.onPrimary
                        ),),
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: _visibleUsernameMessage,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
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
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: MyButton(
                    key: _buttonKey,
                    child: Text("Continue"),
                    onPressed: () {
                      final formState = _formKey.currentState;
                      if (!formState.validate()) {
                        setState(() {
                          _visibleUsernameMessage=false;
                          _autoValidate = true;
                        });
                      } else {
                        if (_isUserNameError) {
                          MySnackbar.show('Error',
                              'Verify your username first');
                        } else {
                          _buttonKey.currentState
                              .showLoader();
                          formState.save();
                          signInWithSocialMedia(
                              socialToken: widget
                                  .accessToken,
                              socialAuthType: widget
                                  .authType,
                              userName: userName).then((
                              value) {
                            _buttonKey.currentState
                                .hideLoader();
                            onAuthenticationSuccess(
                                value);
                          }).catchError((err) {
                            _buttonKey.currentState
                                .hideLoader();
                            MySnackbar.show('Error',
                                err?.toString());
                          });
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
