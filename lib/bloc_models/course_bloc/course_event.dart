

import 'package:ecommerceapp/api_services/course_api_services.dart';
import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/course_bloc/index.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 2:48 PM
///


@immutable
abstract class CourseEvent {
  Stream<BaseState> applyAsync({BaseState currentState, CourseBloc bloc});
}

class LoadMyCoursesEvent extends CourseEvent{
  @override
  Stream<BaseState> applyAsync({BaseState currentState, CourseBloc bloc}) async* {
    try{
      yield LoadingBaseState();
      final  result = await getAllCourses();
      bloc.courses = result.data;
      yield CourseLoadedState();
    }catch(_,s){
      print(s);
      yield ErrorBaseState(_?.toString());
    }
  }
}

