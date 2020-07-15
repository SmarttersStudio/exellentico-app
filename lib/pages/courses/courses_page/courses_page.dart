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


  @override
  void initState() {
    super.initState();
    CourseBloc().add(LoadMyCoursesEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Courses"),),
      body: BlocBuilder<CourseBloc, BaseState>(
        bloc: CourseBloc(),
        builder: (context, BaseState state){
          if(state is LoadingBaseState){
            return Center(child: CircularProgressIndicator());
          }
          if(state is ErrorBaseState){
            return Center(child: Text(state.errorMessage.toString()),);
          }
          if(state is EmptyBaseState){
            return Center(child: Text("No Courses Available"),);
          }
          if(state is CourseLoadedState){
            return ListView.separated(
              itemCount: CourseBloc().courses.length,
              separatorBuilder: (context, index)=>Divider(),
                itemBuilder: (context, index)=>InkWell(
                  onTap: (){
                    Get.to(ChaptersPage(courseId: CourseBloc().courses[index].id,));
                  },
                    child: CourseCard(CourseBloc().courses[index])
                )
            );
          }
          return Center(child: Text("Some Error Occurred "),);
        },
      ),
    );
  }
}
