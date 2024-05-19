import 'package:flutter/material.dart';
import 'package:sara_front/components/text.dart';

class Home extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: text(text1: 'S.A.R.A',),centerTitle: true,),


body: Center(child: text(text1: "Home page",),),
    );
  }
}
