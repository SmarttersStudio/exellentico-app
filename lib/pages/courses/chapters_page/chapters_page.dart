import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/chapter_bloc/index.dart';
import 'package:ecommerceapp/data_models/course_data.dart';
import 'package:ecommerceapp/pages/courses/chapters_page/components/chapter_card.dart';
import 'package:ecommerceapp/pages/courses/episodes_page/episodes_page.dart';
import 'package:ecommerceapp/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 6:30 AM
///

class ChaptersPage extends StatefulWidget {
  final CourseDatum course;
  ChaptersPage({this.course});
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
      initialVideoId: widget.course.promoVideo,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    ChapterBloc().add(LoadMyChaptersEvent(widget.course.id));
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= 200) {
        ChapterBloc().add(LoadMoreChaptersEvent(widget.course.id));
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
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              topActions: [
                BackButton(
                  color: Colors.white,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                widget.course.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            BlocBuilder<ChapterBloc, BaseState>(
              builder: (context, BaseState state) {
                if (state is LoadingBaseState) {
                  return Center(child: ExellenticoProgress());
                }
                if (state is ErrorBaseState) {
                  return Center(
                    child: Text(state.errorMessage.toString()),
                  );
                }
                if (state is EmptyBaseState) {
                  return Center(
                    child: Text("No Chapters Available"),
                  );
                }
                if (state is ChapterLoadedState) {
                  return Expanded(
                    child: ListView.separated(
                        itemCount: ChapterBloc().chapterShouldLoadMore
                            ? ChapterBloc().chapters.length + 1
                            : ChapterBloc().chapters.length,
                        separatorBuilder: (context, index) => Divider(
                              height: 1,
                            ),
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
                return Center(
                  child: Text("Some Error Occurred "),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
