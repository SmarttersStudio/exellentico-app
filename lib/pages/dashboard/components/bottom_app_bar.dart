import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar on 07-07-2020 11:03 AM.
///
class DashboardBottomAppbar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onPageChange;

  const DashboardBottomAppbar({this.currentIndex = 1, this.onPageChange});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
        decoration: BoxDecoration(boxShadow: [
//        BoxShadow(
//            color: colorScheme.brightness == Brightness.light
//                ? Colors.grey[200]
//                : Colors.white12,
//            offset: Offset(0, -1),
//            blurRadius: 10)
        ], borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            selectedItemColor: colorScheme.primary,
            onTap: onPageChange,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore), title: Text('Explore')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.help), title: Text('Doubt')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Profile')),
            ]));
  }
}
