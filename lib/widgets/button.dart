import 'package:ecommerceapp/config/colors.dart';
import 'package:ecommerceapp/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/13/2020 11:46 PM
///

class ExellenticoButton extends StatefulWidget {
  const ExellenticoButton(
      {required this.child,
      Key? key,
      this.gradient,
      this.onPressed,
      this.height,
      this.width,
      this.disableGradient})
      : super(key: key);

  final Widget child;
  final Gradient? gradient, disableGradient;
  final VoidCallback? onPressed;
  final double? height, width;

  @override
  ExellenticoButtonState createState() => ExellenticoButtonState();
}

class ExellenticoButtonState extends State<ExellenticoButton> {
  bool _isLoading = false;

  void showLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    Gradient gradientCopy;

    if (widget.onPressed == null) {
      gradientCopy = widget.disableGradient ??
          (colorScheme.brightness == Brightness.light
              ? LinearGradient(
                  colors: <Color>[Colors.grey[500]!, Colors.grey[400]!])
              : LinearGradient(
                  colors: <Color>[Colors.grey[600]!, Colors.grey[500]!]));
    } else {
      gradientCopy = widget.gradient ?? getDynamicGradient(context);
    }
    return _isLoading
        ? ExellenticoProgress()
        : RaisedButton(
            onPressed: widget.onPressed,
            disabledTextColor: Colors.white,
            shape: StadiumBorder(),
            padding: EdgeInsets.all(0.0),
            textColor: Colors.white,
            child: Ink(
                decoration: BoxDecoration(
                    gradient: gradientCopy,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints.tightFor(
                      width: widget.width ?? 350.0,
                      height: widget.height ?? 50.0),
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      child: widget.child),
                )),
          );
  }
}
