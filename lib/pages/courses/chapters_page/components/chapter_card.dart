import 'package:ecommerceapp/data_models/chapter_data.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 7:45 AM
///

class ChapterCard extends StatelessWidget {
  final ChapterDatum data;
  ChapterCard({this.data});
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
              backgroundImage: NetworkImage('https://th.thgim.com/opinion/lead/m77apn/article29986291.ece/alternates/FREE_435/Th16-Mattoo-Education-policy'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.name??'', style: TextStyle(
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
