
import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/chapter_bloc/index.dart';
import 'package:ecommerceapp/data_models/chapter_data.dart';


///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 2:47 PM
///


class ChapterBloc extends Bloc<ChapterEvent, BaseState> {
  static final ChapterBloc _chapterBlocSingleton = ChapterBloc._internal();
  factory ChapterBloc() {
    return _chapterBlocSingleton;
  }
  ChapterBloc._internal();


  @override
  BaseState get initialState => ChapterState();

  @override
  Future<void> close() async {
    _chapterBlocSingleton.close();
    await super.close();
  }

  List<ChapterDatum> chapters  = [];

  @override
  Stream<BaseState> mapEventToState(
      ChapterEvent event,
      ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ChapterBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}




