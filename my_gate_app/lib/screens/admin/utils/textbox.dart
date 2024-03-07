// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextBoxCustom extends StatelessWidget {
  TextBoxCustom({
    super.key,
    required this.labelText,
    this.onSavedFunction,
    required this.icon,
    this.form_key,
    this.onChangedFunction,
  });
  void Function(String?)? onSavedFunction;
  void Function(String?)? onChangedFunction;
  String labelText;
  Icon icon;
  Key? form_key;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(titleMedium: TextStyle(color: Colors.black)),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        color: Colors.white,
        child: Form(
          key: form_key,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            key: const ValueKey('username'),
            // how does this work?
            validator: (value) {
              if (value!.isEmpty) {
                return '$labelText is empty';
              }
              return null;
            },
            onSaved: onSavedFunction,
            onChanged: onChangedFunction,
            decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                floatingLabelStyle: TextStyle(color: Colors.black),
                prefixStyle: TextStyle(color: Colors.black),
                fillColor: Colors.deepOrange,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                prefixIcon: icon,

                // border: OutlineInputBorder(
                //   borderRadius: new BorderRadius.circular(8.0),
                //   borderSide: const BorderSide(),
                // ),
                labelText: labelText //"Enter New Location",
                // labelStyle: GoogleFonts.roboto(),
                ),
          ),
        ),
      ),
    );
  }
}
