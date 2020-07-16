import 'package:ecommerceapp/bloc_models/theme_bloc/index.dart';
import 'package:ecommerceapp/pages/authentication/login/login_page.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/otp_page.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/reset_password_page.dart';
import 'package:ecommerceapp/pages/authentication/reset_password/update_password_page.dart';
import 'package:ecommerceapp/pages/authentication/signup/signup_page.dart';
import 'package:ecommerceapp/pages/authentication/social_sign_in/social_sign_in_page.dart';
import 'package:ecommerceapp/pages/onboarding/verify_phone/verify_phone_page.dart';
import 'package:ecommerceapp/utils/notification_services/in_app_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created By Guru (guru@smarttersstudio.com) on 12/06/20 12:50 PM
///

class MyHomePage extends StatefulWidget {
  static final routeName = '/';
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '0',
//              style: Theme.of(context).textTheme.headline4,
//            ),
            RaisedButton(
              child: Text("Phone verify"),
                onPressed: ()=>Get.to(VerifyPhonePage())),
            RaisedButton(
                child: Text("Signup"),
                onPressed: (){
                  Navigator.pushNamed(context, SignUpPage.routeName);
                }),
            RaisedButton(
                child: Text("Reset"),
                onPressed: (){
                  Navigator.pushNamed(context, ResetPasswordPage.routeName);
                }),
              RaisedButton(
                  child: Text("Pin View"),
                  onPressed: (){
                      Navigator.pushNamed(context, OTPPage.routeName);
                  }),
              RaisedButton(
                  child: Text("Update Password"),
                  onPressed: (){
                      Navigator.pushNamed(context, UpdatePasswordPage.routeName);
                  }),
            RaisedButton(
                child: Text("social"),
                onPressed: ()=>Get.to(SocialSignInPage())
                ),
            RaisedButton(
                child: Text("Image notification"),
                onPressed: () async {
                  await InAppNotification.showNotification(
                    title: 'NotifyX',
                      description: "This is a new type of notification",
                      iconUrl: "https://optinmonster.com/wp-content/uploads/2018/05/ecommerce-lead-generation-tips-1.jpg",
                      imageUrl: "https://optinmonster.com/wp-content/uploads/2018/05/ecommerce-lead-generation-tips-1.jpg"
                  );
                }
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
              heroTag: 1,
            onPressed: makeDark,
            tooltip: 'Dark',
            child: Text('dark'),
          ),
          FloatingActionButton(
              heroTag: 2,
            onPressed: makeLight,
            tooltip: 'Light',
            child: Text('Light'),
          )
        ],
      ),
    );
  }

  void makeLight() {
    ThemeBloc().add(ThemeChanged(ThemeMode.light));
  }
  void makeDark() {
    ThemeBloc().add(ThemeChanged(ThemeMode.dark));
  }
}
