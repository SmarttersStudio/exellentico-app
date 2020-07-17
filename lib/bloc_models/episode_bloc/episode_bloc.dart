import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/bloc_models/episode_bloc/index.dart';
import 'package:ecommerceapp/data_models/episode_data.dart';

import '../base_state.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 2:47 PM
///

class EpisodeBloc extends Bloc<EpisodeEvent, BaseState> {
  static final EpisodeBloc _episodeBlocSingleton = EpisodeBloc._internal();
  factory EpisodeBloc() {
    return _episodeBlocSingleton;
  }
  EpisodeBloc._internal() : super(EpisodeState());

  @override
  Future<void> close() async {
    _episodeBlocSingleton.close();
    await super.close();
  }

  List<EpisodeDatum> episodes = [];
  bool episodeShouldLoadMore = true;
  int episodeSkipData = 0;

  @override
  Stream<BaseState> mapEventToState(
    EpisodeEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'EpisodeBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
