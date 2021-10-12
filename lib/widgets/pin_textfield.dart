import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar on 06-07-2020 03:15 PM.
///
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PinCodeTextField extends StatefulWidget {
  final int length;
  final double fieldHeight, fieldWidth;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? disableColor, enableFillColor, enableEmptyColor;
  final bool obsecureText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onSubmitted;
  final TextStyle textStyle;
  final Color backgroundColor;
  final MainAxisAlignment mainAxisAlignment;
  final TextInputType textInputType;
  final bool autoFocus;
  final FocusNode? focusNode;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final TextEditingController? controller;
  final bool enableActiveFill;
  final bool autoDismissKeyboard;
  final bool autoDisposeControllers;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final Brightness keyboardAppearance;
  final FormFieldValidator<String>? validator;
  final bool autoValidate;

  PinCodeTextField({
    Key? key,
    required this.length,
    this.controller,
    this.obsecureText = false,
    required this.onChanged,
    this.onCompleted,
    this.backgroundColor = Colors.white,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.textInputType = TextInputType.visiblePassword,
    this.autoFocus = false,
    this.focusNode,
    this.enabled = true,
    this.inputFormatters = const <TextInputFormatter>[],
    this.textStyle = const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    this.enableActiveFill = true,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.autoDismissKeyboard = true,
    this.autoDisposeControllers = true,
    this.onSubmitted,
    this.keyboardAppearance = Brightness.light,
    this.validator,
    this.autoValidate = false,
    this.fieldHeight = 54,
    this.fieldWidth = 54,
    this.borderRadius,
    this.border,
    this.disableColor,
    this.enableFillColor,
    this.enableEmptyColor,
  }) : super(key: key);

  @override
  _PinCodeTextFieldState createState() => _PinCodeTextFieldState();
}

class _PinCodeTextFieldState extends State<PinCodeTextField> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late List<String> _inputList;
  int _selectedIndex = 0;

  @override
  void initState() {
    _checkForInvalidValues();
    _assignController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    _inputList = List.empty();
    _initializeValues();
    super.initState();
  }

  void _checkForInvalidValues() {
    assert(widget.length != null && widget.length > 0);
    assert(widget.obsecureText != null);
    assert(widget.backgroundColor != null);
    assert(widget.mainAxisAlignment != null);
    assert(widget.textStyle != null);
    assert(widget.textInputType != null);
    assert(widget.autoFocus != null);
    assert(widget.enableActiveFill != null);
    assert(widget.textCapitalization != null);
    assert(widget.textInputAction != null);
    assert(widget.autoDisposeControllers != null);
    assert(widget.autoValidate != null);
  }

  void _assignController() {
    if (widget.controller == null) {
      _textEditingController = TextEditingController();
    } else {
      _textEditingController = widget.controller!;
    }
    _textEditingController.addListener(() {
      var currentText = _textEditingController.text;

      if (widget.enabled && _inputList.join("") != currentText) {
        if (currentText.length >= widget.length) {
          if (widget.onCompleted != null) {
            if (currentText.length > widget.length) {
              // removing extra text longer than the length
              currentText = currentText.substring(0, widget.length);
            }
            //  delay the onComplete event handler to give the onChange event handler enough time to complete
            Future.delayed(Duration(milliseconds: 300),
                () => widget.onCompleted?.call(currentText));
          }

          if (widget.autoDismissKeyboard) _focusNode.unfocus();
        }
        if (widget.onChanged != null) {
          widget.onChanged?.call(currentText);
        }
      }

      _setTextToInput(currentText);
    });
  }

  @override
  void dispose() {
    if (widget.autoDisposeControllers) {
      _textEditingController.dispose();
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _initializeValues() {
    for (int i = 0; i < _inputList.length; i++) {
      _inputList[i] = "";
    }
  }

  Color _getFillColorFromIndex(int index) {
    if (!widget.enabled) {
      return Theme.of(context).disabledColor;
    }
    if (_selectedIndex > index) {
      return widget.enableFillColor ?? Theme.of(context).colorScheme.primary;
    }
    return widget.enableEmptyColor ?? Theme.of(context).colorScheme.surface;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.fieldHeight +
          10.0, //widget.pinTheme.fieldHeight + widget.errorTextSpace,
      width: widget.length * (widget.fieldWidth + 12),
//        color: widget.backgroundColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          AbsorbPointer(
            // this is a hidden textfield under the pin code fields.
            absorbing: true, // it prevents on tap on the text field
            child: TextFormField(
              textInputAction: widget.textInputAction,
              controller: _textEditingController,
              focusNode: _focusNode,
              enabled: widget.enabled,
              autofocus: widget.autoFocus,
              autocorrect: false,
              keyboardType: widget.textInputType,
              keyboardAppearance: widget.keyboardAppearance,
              textCapitalization: widget.textCapitalization,
              validator: widget.validator,
              autovalidate: widget.autoValidate,
              inputFormatters: [
                ...widget.inputFormatters,
                LengthLimitingTextInputFormatter(
                  widget.length,
                ),
              ],
              onFieldSubmitted: widget.onSubmitted,
              enableInteractiveSelection: false,
              showCursor: true,
              cursorColor: widget.backgroundColor,
              cursorWidth: 0.01,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorStyle: TextStyle(
                    fontSize: 18,
                  )),
              style: TextStyle(
                color: Colors.transparent,
                height: .01,
                fontSize: 0.01,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: _onFocus,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: widget.mainAxisAlignment,
                children: _generateFields(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateFields() {
    var result = <Widget>[];
    for (int i = 0; i < widget.length; i++) {
      result.add(
        Container(
          width: 44,
          margin: const EdgeInsets.only(left: 12),
          height: 44,
          decoration: BoxDecoration(
              color: widget.enableActiveFill
                  ? _getFillColorFromIndex(i)
                  : Colors.transparent,
              shape: BoxShape.circle,
              borderRadius: widget.borderRadius,
              border: widget.border),
          child: Center(
            child: AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Text(
                widget.obsecureText && _inputList[i].isNotEmpty
                    ? "*"
                    : _inputList[i],
                key: ValueKey(_inputList[i]),
                style: widget.textStyle,
              ),
            ),
          ),
        ),
      );
    }
    return result;
  }

  void _onFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
      Future.delayed(const Duration(microseconds: 1),
          () => FocusScope.of(context).requestFocus(_focusNode));
    } else {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  void _setTextToInput(String data) async {
    List<String> replaceInputList = [];

    for (int i = 0; i < widget.length; i++) {
      replaceInputList[i] = data.length > i ? data[i] : "";
    }

    setState(() {
      _selectedIndex = data.length;
      _inputList = replaceInputList;
    });
  }
}
