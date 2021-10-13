import 'package:ecommerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

///
/// Created by Sunil Kumar on 17-07-2020 11:13 AM.
///
class AuthScaffold extends StatelessWidget {
  final Widget? body;
  const AuthScaffold({this.body});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
              child: ColoredBox(color: theme.scaffoldBackgroundColor)),
          Positioned(
            right: 0,
            top: 0,
            child: SvgPicture.asset('assets/icons/login_vector.svg'),
          ),
          Positioned(
              left: 32,
              top: 52,
              child: SafeArea(
                child: Row(
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      S.of(context).exellentico,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )),
          if (body != null) body!,
          if (Navigator.canPop(context))
            Positioned(child: SafeArea(child: BackButton())),
        ],
      ),
    );
  }
}
