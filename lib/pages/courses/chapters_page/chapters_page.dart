import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/chapter_bloc/index.dart';
import 'package:ecommerceapp/pages/courses/chapters_page/components/chapter_card.dart';
import 'package:ecommerceapp/pages/courses/episodes_page/episodes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 6:30 AM
///

class ChaptersPage extends StatefulWidget {
  final String courseId;
  ChaptersPage({this.courseId});
  @override
  _ChaptersPageState createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {


  @override
  void initState() {
    super.initState();
    ChapterBloc().add(LoadMyChaptersEvent(widget.courseId));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chapters"),),
      body: BlocBuilder<ChapterBloc, BaseState>(
        bloc: ChapterBloc(),
        builder: (context, BaseState state){
          if(state is LoadingBaseState){
            return Center(child: CircularProgressIndicator());
          }
          if(state is ErrorBaseState){
            return Center(child: Text(state.errorMessage.toString()),);
          }
          if(state is EmptyBaseState){
            return Center(child: Text("No Chapters Available"),);
          }
          if(state is ChapterLoadedState){
            return ListView.separated(
                itemCount: ChapterBloc().chapters.length,
                separatorBuilder: (context, index)=>Divider(),
                itemBuilder: (context, index)=>InkWell(
                    onTap: (){
                      Get.to(EpisodesPage(ChapterBloc().chapters[index].id,));
                    },
                    child: ChapterCard(data: ChapterBloc().chapters[index],)
                )
            );
          }
          return Center(child: Text("Some Error Occurred "),);
        },
      ),
    );
  }
}
