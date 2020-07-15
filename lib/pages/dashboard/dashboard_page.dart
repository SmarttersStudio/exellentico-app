import 'package:ecommerceapp/pages/courses/courses_page/courses_page.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:ecommerceapp/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text("Dashboard Page", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),),
            ),
            MyButton(
              width: 200,
                child: Text("My Courses"),
              onPressed: (){
                  Get.to(CoursesPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

