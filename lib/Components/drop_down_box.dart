import 'package:flutter/material.dart';
import 'package:flutter_projects/constants.dart';

class BuildDropdown extends StatefulWidget {
  final ValueChanged<String> onChanged;
  String defaultValue, selectedValue, dropdownHint;
  List<String> itemsList;

  BuildDropdown(
      {
        required this.itemsList,
        this.defaultValue = "",
        this.dropdownHint = "",
        this.selectedValue = "",
        required this.onChanged});

  @override
  _BuildDropdownState createState() => _BuildDropdownState();
}

class _BuildDropdownState extends State<BuildDropdown> {
  String _value="";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      margin: EdgeInsets.only(top: 8),
      color: Colors.white,
      child: DropdownButton<String>(
        items: widget.itemsList.map(
              (String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: Center(child: new Text(value)),
            );
          },
        ).toList(),
        value: widget.selectedValue.isNotEmpty ? widget.selectedValue : widget.defaultValue,
        isExpanded: true,
        onChanged: (value){
          setState(() {
            widget.selectedValue = value!;
          });
          widget.onChanged(value!);
        },
        hint: Center(
          child: Text(widget.dropdownHint,style: TextStyle(
            fontSize: 15,color: primaryColor
          ),),
        ),
        style: TextStyle(
          fontSize: 20,
          color: primaryColor,
        ),
        iconEnabledColor: secondaryColor,
        iconSize: 14,
        underline: Container(),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}