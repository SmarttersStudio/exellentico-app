import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

///
/// Created by Sunil Kumar on 07-07-2020 05:57 PM.
///
class AppBarAction extends StatelessWidget {
  final String path;
  final VoidCallback? onTap;
  const AppBarAction(this.path, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(path),
        ),
      ),
    );
  }
}
