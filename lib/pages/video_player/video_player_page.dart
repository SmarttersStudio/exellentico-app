import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoCode,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
            ),
            SizedBox(height: 50,),
            Text("Video Player is Under Construction")
          ],
        ),
      ),
    );
  }
}
