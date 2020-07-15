import 'package:ecommerceapp/api_services/course_api_services.dart';
import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/episode_bloc/index.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 2:48 PM
///

@immutable
abstract class EpisodeEvent {
  Stream<BaseState> applyAsync({BaseState currentState, EpisodeBloc bloc});
}

class LoadMyEpisodesEvent extends EpisodeEvent{
  final String chapterId;
  LoadMyEpisodesEvent(this.chapterId);
  @override
  Stream<BaseState> applyAsync({BaseState currentState, EpisodeBloc bloc}) async* {
    try{
      yield LoadingBaseState();
      final  result = await getAllEpisodes(chapterId);
      bloc.episodes = result.data;
      yield EpisodeLoadedState();
    }catch(_,s){
      print(s);
      yield ErrorBaseState(_?.toString());
    }
  }
}

