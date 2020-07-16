import 'package:ecommerceapp/bloc_models/base_state.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 2:54 PM
///




/// Initialized
class EpisodeState extends BaseState {

  EpisodeState();

  @override
  String toString() => 'EpisodeState';

  @override
  BaseState getStateCopy() {
    return EpisodeState();
  }
}

///loaded
class EpisodeLoadedState extends BaseState{
  EpisodeLoadedState();

  @override
  String toString() => 'EpisodeLoadedState';

  @override
  BaseState getStateCopy() {
    return EpisodeLoadedState();
  }
}
