import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'index.dart';
import '../base_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, BaseState> {
  static final ThemeBloc _themeBlocSingleton = ThemeBloc._internal();
  factory ThemeBloc() {
    return _themeBlocSingleton;
  }
  ThemeBloc._internal()
      : super(ThemeState(SharedPreferenceHelper.themeColor,
            SharedPreferenceHelper.themeMode));

  @override
  Future<void> close() async {
    _themeBlocSingleton.close();
    await super.close();
  }

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
