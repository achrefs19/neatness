import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  VoidCallback? fun;
  String txt;
  Color backGroundColor;
  Color textColor;
  IconData icon;
  double radius;
  RadioButton({this.fun ,this.txt = "", this.backGroundColor = Colors.black, this.textColor = Colors.white, this.icon = Icons.verified, this.radius = 10});

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
}