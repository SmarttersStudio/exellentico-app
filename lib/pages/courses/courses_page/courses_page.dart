import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/course_bloc/index.dart';
import 'package:ecommerceapp/pages/courses/chapters_page/chapters_page.dart';
import 'package:ecommerceapp/pages/courses/courses_page/components/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/15/2020 6:29 AM
///

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= 200) {
        CourseBloc().add(LoadMoreCoursesEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: BlocBuilder<CourseBloc, BaseState>(
        builder: (context, BaseState state) {
          if (state is LoadingBaseState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ErrorBaseState) {
            return Center(
              child: Text(state.errorMessage.toString()),
            );
          }
          if (state is EmptyBaseState) {
            return Center(
              child: Text("No Courses Available"),
            );
          }
          if (state is CourseLoadedState) {
            return ListView.separated(
                controller: _scrollController,
                itemCount: CourseBloc().courseShouldLoadMore
                    ? CourseBloc().courses.length + 1
                    : CourseBloc().courses.length,
                separatorBuilder: (context, index) => Divider(
                      height: 1,
                    ),
                itemBuilder: (context, index) =>
                    index >= CourseBloc().courses.length
                        ? CourseBloc().courseShouldLoadMore
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container()
                        : InkWell(
                            onTap: () {
                              Get.to(ChaptersPage(
                                course: CourseBloc().courses[index],
                              ));
                            },
                            child: CourseCard(CourseBloc().courses[index])));
          }
          return Center(
            child: Text("Some Error Occurred "),
          );
        },
      ),
    );
  }
}
