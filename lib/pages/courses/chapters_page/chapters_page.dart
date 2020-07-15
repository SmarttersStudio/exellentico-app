import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/chapter_bloc/index.dart';
import 'package:ecommerceapp/pages/courses/chapters_page/components/chapter_card.dart';
import 'package:ecommerceapp/pages/courses/episodes_page/episodes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 6:30 AM
///

class ChaptersPage extends StatefulWidget {
  final String courseId;
  final String videoCode;
  ChaptersPage({this.courseId, this.videoCode});
  @override
  _ChaptersPageState createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {

  YoutubePlayerController _controller;
  final ScrollController _scrollController = ScrollController();

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
    ChapterBloc().add(LoadMyChaptersEvent(widget.courseId));
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= 200) {
        ChapterBloc().add(LoadMoreChaptersEvent(widget.courseId));
      }
    });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chapters"),),
      body: Column(
        children: [
          YoutubePlayer(
              controller: _controller,
          ),
          BlocBuilder<ChapterBloc, BaseState>(
            bloc: ChapterBloc(),
            builder: (context, BaseState state){
              if(state is LoadingBaseState){
                return Center(child: Container(child: CircularProgressIndicator()));
              }
              if(state is ErrorBaseState){
                return Center(child: Text(state.errorMessage.toString()),);
              }
              if(state is EmptyBaseState){
                return Center(child: Text("No Chapters Available"),);
              }
              if(state is ChapterLoadedState){
                return Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                      itemCount: ChapterBloc().chapterShouldLoadMore
                          ? ChapterBloc().chapters.length + 1
                          : ChapterBloc().chapters.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) =>
                          index >= ChapterBloc().chapters.length
                              ? ChapterBloc().chapterShouldLoadMore
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container()
                              : InkWell(
                                  onTap: () {
                                    Get.to(EpisodesPage(
                                      ChapterBloc().chapters[index].id,
                                    ));
                                  },
                                  child: ChapterCard(
                                    data: ChapterBloc().chapters[index],
                                  ))),
                );
              }
              return Center(child: Text("Some Error Occurred "),);
            },
          )
        ],
      ),
    );
  }
}
