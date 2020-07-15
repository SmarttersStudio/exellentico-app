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
    return data==null?Container():Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(data!=null?data.avatar??'':''),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title??'', style: TextStyle(
                fontSize: 15
              ),),
              Text(data.description??'', style: TextStyle(
                fontSize: 12
              ),)
            ],
          )
        ],
      ),
    );
  }
}
