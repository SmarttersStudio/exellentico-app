import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/course_bloc/index.dart';
import 'package:ecommerceapp/data_models/course_data.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 2:47 PM
///

class CourseBloc extends Bloc<CourseEvent, BaseState> {
  static final CourseBloc _courseBlocSingleton = CourseBloc._internal();
  factory CourseBloc() {
    return _courseBlocSingleton;
  }
  CourseBloc._internal() : super(CourseState());

  @override
  Future<void> close() async {
    _courseBlocSingleton.close();
    await super.close();
  }

  List<CourseDatum> courses = [];
  bool courseShouldLoadMore = true;
  int courseSkipData = 0;

  @override
  Stream<BaseState> mapEventToState(
    CourseEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'CourseBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
