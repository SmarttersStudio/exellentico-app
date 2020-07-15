import 'package:ecommerceapp/data_models/episode_data.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 7:57 AM
///

class EpisodesCard extends StatelessWidget {
  final EpisodeDatum data;
  EpisodesCard({this.data});
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
              backgroundImage: NetworkImage('https://www.newsfolo.com/wp-content/uploads/2017/08/youtube.jpg'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title??'', style: TextStyle(
                  fontSize: 15
              ),),
              Text("video code : "+data.youtubeCode??'', style: TextStyle(
                  fontSize: 12
              ),)
            ],
          )
        ],
      ),
    );
  }
}
