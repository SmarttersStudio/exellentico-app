import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/13/2020 11:46 PM
///

class MyButton extends StatefulWidget {
  const MyButton(
      {@required this.child,
      Key key,
      this.gradient,
      this.onPressed,
      this.height,
      this.width,
      this.disableGradient})
      : super(key: key);

  final Widget child;
  final Gradient gradient, disableGradient;
  final VoidCallback onPressed;
  final double height, width;

  @override
  MyButtonState createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
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
                  colors: <Color>[Colors.grey[500], Colors.grey[400]])
              : LinearGradient(
                  colors: <Color>[Colors.grey[600], Colors.grey[500]]));
    } else {
      gradientCopy = widget.gradient ??
          LinearGradient(
              begin: Alignment(1, 0.5694444179534912),
              end: Alignment(0.0882352963089943, 0.5),
              colors: [const Color(0xfffe9654), const Color(0xfffd6c57)]);
    }
    return _isLoading
        ? Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(colorScheme.primary),
            ))
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
                  child: widget.child,
                )),
          );
  }
}
