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
  final int skip = 0;
  final int limit = 10;
  LoadMyEpisodesEvent(this.chapterId);
  @override
  Stream<BaseState> applyAsync({BaseState currentState, EpisodeBloc bloc}) async* {
    try{
      yield LoadingBaseState();
      final  result = await getAllEpisodes(chapterId, skip, limit );
      if (result.data.isEmpty) {
        bloc.episodeSkipData = 0;
        bloc.episodeShouldLoadMore = false;
        yield EmptyBaseState();
      } else {
        if (result.data.length < limit && bloc.episodeSkipData == 0) {
          bloc.episodeShouldLoadMore = false;
        }
        bloc.episodes = result.data;
        yield EpisodeLoadedState();
      }
    }catch(_,s){
      print(s);
      yield ErrorBaseState(_?.toString());
    }
  }
}


class LoadMoreEpisodesEvent extends EpisodeEvent{
  final String chapterId;
  final int limit = 10;
  LoadMoreEpisodesEvent(this.chapterId);
  @override
  Stream<BaseState> applyAsync({BaseState currentState, EpisodeBloc bloc}) async* {
    try{
      if(bloc.episodeShouldLoadMore){
        bloc.episodeSkipData = bloc.episodes.length;
        final  result = await getAllEpisodes(chapterId, bloc.episodeSkipData, limit);
        if(result.data.isEmpty){
          bloc.episodeShouldLoadMore = false;
        }else{
          bloc.episodes += result.data;
        }
        yield EpisodeLoadedState();
      }else{
        yield currentState;
      }
    }catch(_,s){
      print(s);
      yield ErrorBaseState(_?.toString());
    }
  }
}

