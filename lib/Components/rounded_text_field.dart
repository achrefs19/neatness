import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_projects/constants.dart';

class RoundedTextField extends StatelessWidget {
  final Function validator;
  final Function onSaved;
  final String _txtLabel;
  final IconData _prefixIcon;
  final String hintText;
  final double radius;
  final bool isPassword;

  RoundedTextField({Key? key , this.radius = 30, this.isPassword=false ,required Function this.validator,required Function this.onSaved ,required IconData prefixIcon, this.hintText = "Type in your text",required String txtLabel}): _prefixIcon=prefixIcon, _txtLabel=txtLabel, super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      obscureText: isPassword,
      decoration: new InputDecoration(
        suffixStyle: const TextStyle(color: primaryColor),
        prefixIcon: Icon(_prefixIcon,color: primaryColor),
        label: Text(_txtLabel, style: TextStyle(fontSize: 20)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: primaryColor
          )
        ),
        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            style: BorderStyle.none
          )
        ),
        filled: true,
        labelStyle: new TextStyle(color: primaryColor),
        hintText: hintText,
        fillColor: Colors.white70,
      ),
      validator: (e) => validator(e),
      onSaved: (e) => onSaved(e),
    );
  }
}