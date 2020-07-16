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
  final int limit = 10;
  final int skip = 0;
  LoadMyChaptersEvent(this.courseId);
  @override
  Stream<BaseState> applyAsync({BaseState currentState, ChapterBloc bloc}) async* {
    try{
      yield LoadingBaseState();
      final  result = await getAllChapters(courseId, skip, limit);
      if (result.data.isEmpty) {
        bloc.chapterSkipData = 0;
        bloc.chapterShouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.data.length < limit && bloc.chapterSkipData == 0) {
          bloc.chapterShouldLoadMore = false;
        }
        bloc.chapters = result.data;
        yield ChapterLoadedState();
      }
    }catch(_,s){
      print(s);
      yield ErrorBaseState(_?.toString());
    }
  }
}

class LoadMoreChaptersEvent extends ChapterEvent{
  final String courseId;
  final int limit = 10;
  LoadMoreChaptersEvent(this.courseId);
  @override
  Stream<BaseState> applyAsync({BaseState currentState, ChapterBloc bloc}) async* {
    try{
      if(bloc.chapterShouldLoadMore){
        bloc.chapterSkipData = bloc.chapters.length;
        final  result = await getAllChapters(courseId, bloc.chapterSkipData, limit);
        if(result.data.isEmpty){
          bloc.chapterShouldLoadMore = false;
        }else{
          bloc.chapters += result.data;
        }
        yield ChapterLoadedState();
      }else{
        yield currentState;
      }
    }catch(_,s){
      print(s);
      yield ErrorBaseState(_?.toString());
    }
  }
}
