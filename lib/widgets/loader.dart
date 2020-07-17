import 'package:ecommerceapp/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar on 17-07-2020 03:35 PM.
///
class LoaderOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Get.theme.scaffoldBackgroundColor.withOpacity(0.8);

  @override
  String get barrierLabel => 'loader-overlay';

  @override
  Future<RoutePopDisposition> willPop() async {
    return RoutePopDisposition.doNotPop;
  }

  @override
  bool get maintainState => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExellenticoProgress(),
          SizedBox(
            height: 8,
          ),
          Text(
            'Please wait...',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
