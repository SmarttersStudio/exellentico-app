import 'package:ecommerceapp/config/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/22/2020 2:04 PM
///

class PinView extends StatefulWidget {
    final int fields;
    final ValueChanged<String> onSubmit;
    final Function onDelete;
    final bool isTextObscure;
    final Function onFocus;
    final Color focusedBorderColor;

    PinView({this.fields: 4, this.onSubmit,this.focusedBorderColor = Colors.red, this.isTextObscure: false,this.onDelete, this.onFocus})
        : assert(fields > 0);

    @override
  _PinViewState createState() => _PinViewState();
}

class _PinViewState extends State<PinView> {
    List<String> _pin;
    List<FocusNode> _focusNodes;
    List<TextEditingController> _textControllers;

    Widget textFields = Container();

    @override
    void initState() {
        super.initState();
        _pin = List<String>(widget.fields);
        _focusNodes = List<FocusNode>(widget.fields);
        _textControllers = List<TextEditingController>(widget.fields);
        WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
                textFields = generateTextFields(context);
            });
            widget.onFocus();
        });
    }

    @override
    void dispose() {
        _textControllers.forEach((TextEditingController t) => t.dispose());
        super.dispose();
    }

    Widget generateTextFields(BuildContext context) {
        List<Widget> textFields = List.generate(widget.fields, (int i) {
            return buildTextField(i, context, i == 0);
        });

        if (_pin.first != null) {
            FocusScope.of(context).requestFocus(_focusNodes[0]);
        }

        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: textFields);
    }

    void clearTextFields() {
        _textControllers.forEach(
                (TextEditingController tEditController) => tEditController.clear());
        _pin.clear();
    }

    Widget buildTextField(int i, BuildContext context, [bool autoFocus = false]) {
        if (_focusNodes[i] == null) {
            _focusNodes[i] = FocusNode();
        }
        if (_textControllers[i] == null) {
            _textControllers[i] = TextEditingController();
        }

        _focusNodes[i].addListener(() {
            if (_focusNodes[i].hasFocus) {
                widget.onFocus();
            }
        });

        final String lastDigit = _textControllers[i].text;

        return Container(
            width: 40,
            margin: EdgeInsets.only(right: 10.0),
            child: TextField(
                controller: _textControllers[i],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                textInputAction: TextInputAction.next,
                autofocus: autoFocus,
                focusNode: _focusNodes[i],
                inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(widget.fields),
                ],
                obscureText: widget.isTextObscure,
                decoration: MyDecorations.textFieldDecoration().copyWith(
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2,color: widget.focusedBorderColor))
                )
                    .copyWith(counterText: '', contentPadding: const EdgeInsets.all(0)),
                onChanged: (String str) {
                    setState(() {
                        _pin[i] = str;
                    });
                    if (i + 1 != widget.fields) {
                        _focusNodes[i].unfocus();
                        if(_pin[i].isEmpty){
                            widget.onDelete();
                            if (lastDigit != null) {
                                if(i!=0){
                                    FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
                                }else{
                                    FocusScope.of(context).requestFocus(_focusNodes[i]);
                                }
                            } else {
                                FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
                            }
                        }else {
                            FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
                        }
                    } else {
                        _focusNodes[i].unfocus();
                        if(_pin[i].isEmpty){
                            widget.onDelete();
                            if (lastDigit != null ) {
                                FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
                            }
                        }
                    }
                    if (_pin.every((String digit) => digit != null && digit != '')) {
                        widget.onSubmit(_pin.join());
                    }
                },
                onSubmitted: (String str) {
                    if (_pin.every((String digit) => digit != null && digit != '')) {
                        widget.onSubmit(_pin.join());
                    }
                },
            ),
        );
    }
    @override
    Widget build(BuildContext context) {
        return textFields;
    }
}
