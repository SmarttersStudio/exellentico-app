import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:ecommerceapp/widgets/my_button.dart';
import 'package:flutter/material.dart';

///
/// Created By (aurosmruti@smarttersstudio.com) on 7/13/2020 8:29 PM
///

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dashboard Page"),
            MyButton(
                child: Text("test"),
              onPressed: (){
                  print(SharedPreferenceHelper.user.user.phone);
              },
            ),
          ],
        ),
      ),
    );
  }
}

