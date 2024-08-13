import 'dart:ui';

import 'package:flutter/material.dart';

class text extends StatelessWidget {
  text({Key? key,
    required this.text1,
    this.fontWeight=FontWeight.bold,
    this.color=Colors.black87,
    this.size=14,
    this.font='text normal',
  this.themestyle}) : super(key: key);
    String text1;
    double?size;
    FontWeight?fontWeight;
    Color?color;
    String? font;
    TextStyle? themestyle;
  @override
   Widget build(BuildContext context) {
      return Text(text1,
        style:themestyle
      //   TextStyle(
      //     fontSize: size,
      //     fontWeight: fontWeight,
      //     color: color,
      //     fontFamily: font
      // )
      );
    }
}
