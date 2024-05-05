import 'package:flutter/material.dart';

class textButton extends StatelessWidget {
  textButton(
      {Key? key,
        required this.text,
        this.color = Colors.black87,
        required this.onTap,
        this.size=15,
        this.font= 'text normal'
      })
      : super(key: key);
  final String text;
  final Function() onTap;
  Color color;
  double size;
  String font;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[150],
          ),
          child: Text(
            text,
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w400,
                fontFamily: font,
                // decoration: TextDecoration.underline,
                color: color),
          ),
        ));
  }
}
