import 'package:flutter/material.dart';

class TextIcons extends StatelessWidget {
  IconData icon;
  String text;

  TextIcons(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Icon(
          icon,
          color: Color(0xFFFDD30A),
          size: 20,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.grey, fontSize: 15),
        )
      ],
    );
  }
}
