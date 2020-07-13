import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'index.dart';
import '../base_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, BaseState> {
 static final ThemeBloc _ratingBlocSingleton = ThemeBloc._internal();
  factory ThemeBloc() {
    return _ratingBlocSingleton;
  }
  ThemeBloc._internal();
  
  @override
  Future<void> close() async{
    _ratingBlocSingleton.close();
    await super.close();
  }

  @override
  BaseState get initialState => ThemeState(SharedPreferenceHelper.themeColor,SharedPreferenceHelper.themeMode);
  List<String> cities=[];
  @override
  Stream<BaseState> mapEventToState(
    ThemeEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ThemeBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
