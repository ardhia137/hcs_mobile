import 'package:flutter/material.dart';
import 'package:hcs_mobile/utils/theme.dart';

class TextFieldWidget extends StatefulWidget {
  final String text;
  final bool passwordVisible;
  final TextInputType textinput;
  final Function(String?) onsaved;
  final TextEditingController controller;
  final bool isEnabled;
  final String? Function(String?) validator;
  const TextFieldWidget(
      {Key? key,
      required this.text,
      required this.controller,
      this.isEnabled = true,
      this.passwordVisible = false,
      this.textinput = TextInputType.text,
      required this.validator,
      required this.onsaved})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  late bool _passwordVisible;

  void initState() {
    _passwordVisible = false;
  }

  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: widget.validator,
        onSaved: widget.onsaved,
        enabled: widget.isEnabled,
        controller: widget.controller,
        keyboardType: widget.textinput,
        obscureText: widget.passwordVisible != true ? false : !_passwordVisible,
        style: secondaryTextstyle,
        decoration: InputDecoration(
          suffixIcon: widget.passwordVisible != true
              ? const SizedBox()
              : IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: secondaryColor3,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
          labelText: widget.text,
          labelStyle: secondaryTextstyle,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor3)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor3)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor3)),
        ),
      ),
    );
  }
}
