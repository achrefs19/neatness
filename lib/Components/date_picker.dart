/*import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final Function onPressed;
  final String _txtLabel;
  final IconData _prefixIcon;
  final String hintText;
  final bool isPassword;

  DatePicker({Key? key , this.isPassword=false ,required Function this.onPressed,required IconData prefixIcon, this.hintText = "Type in your text",required String txtLabel}): _prefixIcon=prefixIcon, _txtLabel=txtLabel, super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
        onPressed: () => fun,
        label: Text(txt.toUpperCase(), style: TextStyle(fontSize: 14)),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(textColor),
            backgroundColor: MaterialStateProperty.all<Color>(backGroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                    side: BorderSide(color: Colors.red)))));
  }
}*/