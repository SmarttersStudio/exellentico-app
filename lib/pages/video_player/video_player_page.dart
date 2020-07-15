import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 8:32 AM
///


class VideoPlayerPage extends StatefulWidget {
  final String videoCode;
  VideoPlayerPage({this.videoCode});
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Video Player is Under Construction"),),
    );
  }
}
