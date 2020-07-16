import 'package:ecommerceapp/bloc_models/base_state.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 2:49 PM
///


/// Initialized
class CourseState extends BaseState {

  CourseState();

  @override
  String toString() => 'CourseState';

  @override
  BaseState getStateCopy() {
    return CourseState();
  }
}

///loaded
class CourseLoadedState extends BaseState{
  CourseLoadedState();

  @override
  String toString() => 'CourseLoadedState';

  @override
  BaseState getStateCopy() {
    return CourseLoadedState();
  }
}
