import 'package:ecommerceapp/generated/l10n.dart';
import 'package:ecommerceapp/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
/// Created by Sunil Kumar on 17-07-2020 12:13 PM.
///
class SplashPage extends StatefulWidget {
  static const routeName = '/splash';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3)).then((value) {
        checkLevel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffc55ff3), Color(0xff2db2db)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Stack(
          children: [
            Image.asset('assets/images/logo.png'),
            Image.asset('assets/images/name ex.png')
          ],
        ),
      ),
    );
  }
}
