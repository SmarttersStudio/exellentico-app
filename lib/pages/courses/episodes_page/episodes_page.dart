import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/episode_bloc/index.dart';
import 'package:ecommerceapp/pages/courses/episodes_page/components/episode_card.dart';
import 'package:ecommerceapp/pages/video_player/video_player_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 6:30 AM
///
class EpisodesPage extends StatefulWidget {
  final String chapterId;
  EpisodesPage(this.chapterId);
  @override
  _EpisodesPageState createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    EpisodeBloc().add(LoadMyEpisodesEvent(widget.chapterId));
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= 200) {
        EpisodeBloc().add(LoadMoreEpisodesEvent(widget.chapterId));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Episodes"),),
      body: BlocBuilder<EpisodeBloc, BaseState>(
        bloc: EpisodeBloc(),
        builder: (context, BaseState state){
          if(state is LoadingBaseState){
            return Center(child: CircularProgressIndicator());
          }
          if(state is ErrorBaseState){
            return Center(child: Text(state.errorMessage.toString()),);
          }
          if(state is EmptyBaseState){
            return Center(child: Text("No Episodes Available"),);
          }
          if(state is EpisodeLoadedState){
            return ListView.separated(
              controller: _scrollController,
                itemCount: EpisodeBloc().episodeShouldLoadMore
                    ? EpisodeBloc().episodes.length + 1
                    : EpisodeBloc().episodes.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) =>
                    index >= EpisodeBloc().episodes.length
                        ? EpisodeBloc().episodeShouldLoadMore
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container()
                        : InkWell(
                            onTap: () => Get.to(VideoPlayerPage(
                                videoCode:
                                    EpisodeBloc().episodes[index].youtubeCode)),
                            child: EpisodesCard(
                              data: EpisodeBloc().episodes[index],
                            )));
          }
          return Center(child: Text("Some Error Occurred "),);
        },
      ),
    );
  }
}