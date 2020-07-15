import 'package:ecommerceapp/bloc_models/base_state.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 2:54 PM
///




/// Initialized
class ChapterState extends BaseState {

  ChapterState();

  @override
  String toString() => 'ChapterState';

  @override
  BaseState getStateCopy() {
    return ChapterState();
  }
}

///loaded
class ChapterLoadedState extends BaseState{
  ChapterLoadedState();

  @override
  String toString() => 'ChapterLoadedState';

  @override
  BaseState getStateCopy() {
    return ChapterLoadedState();
  }
}
