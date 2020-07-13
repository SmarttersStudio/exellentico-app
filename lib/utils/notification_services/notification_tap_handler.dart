import 'dart:convert';

import 'package:ecommerceapp/pages/authentication/login/login_page.dart';
import 'package:flutter/material.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/18/2020 7:04 AM
///





Future<void> onNotificationTapped(String payload,{String title, String desc}) async{
    print("I have just clicked the notification");
    BuildContext context;
    Map<String, dynamic> data = jsonDecode(payload);
    print(data['type']);
    switch(data['type']){
        case 'login' :
            Navigator.pushNamed(context, LoginPage.routeName );
            break;
    }
}