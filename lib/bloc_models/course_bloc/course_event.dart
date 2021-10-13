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

class LoadMyCoursesEvent extends CourseEvent {
  final int skip = 0;
  final int limit = 10;
  @override
  Stream<BaseState> applyAsync(
      {BaseState? currentState, CourseBloc? bloc}) async* {
    if (bloc == null) return;
    try {
      yield LoadingBaseState();
      final result = await getAllCourses(skip, limit);

      if (result.data.isEmpty) {
        bloc.courseSkipData = 0;
        bloc.courseShouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.data.length < limit && bloc.courseSkipData == 0) {
          bloc.courseShouldLoadMore = false;
        }
        bloc.courses = result.data;
        yield CourseLoadedState();
      }
    } catch (_, s) {
      print(s);
      yield ErrorBaseState(_.toString());
    }
  }
}

class LoadMoreCoursesEvent extends CourseEvent {
  final int limit = 10;
  @override
  Stream<BaseState> applyAsync(
      {BaseState? currentState, CourseBloc? bloc}) async* {
    if (bloc == null) return;
    try {
      if (bloc.courseShouldLoadMore) {
        bloc.courseSkipData = bloc.courses.length;
        final result = await getAllCourses(bloc.courseSkipData, limit);
        if (result.data.isEmpty) {
          bloc.courseShouldLoadMore = false;
        } else {
          bloc.courses += result.data;
        }
        yield CourseLoadedState();
      } else {
        yield currentState!;
      }
    } catch (_, s) {
      print(s);
      yield ErrorBaseState(_.toString());
    }
  }
}
