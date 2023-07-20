import 'package:flutter/material.dart';

class about extends StatelessWidget {
  final String title;
  final String info;
  about({this.title='',this.info=''});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'See All >',
                style: TextStyle(color: Colors.blueAccent),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            info,
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}