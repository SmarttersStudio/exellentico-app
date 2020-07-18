import 'package:ecommerceapp/data_models/course_data.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 7:19 AM
///

class CourseCard extends StatelessWidget {
  final CourseDatum data;
  CourseCard(this.data);
  @override
  Widget build(BuildContext context) {
    return data == null
        ? Container()
        : ListTile(
            leading: Image(
              image: NetworkImage(data != null ? data.avatar ?? '' : ''),
            ),
            title: Text(
              data.title ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              data.description ?? '',
              style: TextStyle(fontSize: 14),
            ));
  }
}
