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
      appBar: AppBar(title: Text("Dashboard"), centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              width: 200,
                child: Text("Go to Courses Page"),
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

