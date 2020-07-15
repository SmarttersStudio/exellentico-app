import 'package:ecommerceapp/api_services/course_api_services.dart';
import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/chapter_bloc/index.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 2:48 PM
///



@immutable
abstract class ChapterEvent {
  Stream<BaseState> applyAsync({BaseState currentState, ChapterBloc bloc});
}

class LoadMyChaptersEvent extends ChapterEvent{
  final String courseId;
  LoadMyChaptersEvent(this.courseId);
  @override
  Stream<BaseState> applyAsync({BaseState currentState, ChapterBloc bloc}) async* {
    try{
      yield LoadingBaseState();
      final  result = await getAllChapters(courseId);
      bloc.chapters = result.data;
      yield ChapterLoadedState();
    }catch(_,s){
      print(s);
      yield ErrorBaseState(_?.toString());
    }
  }
}
