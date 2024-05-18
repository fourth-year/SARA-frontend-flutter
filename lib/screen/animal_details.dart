import 'package:flutter/material.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/text.dart';

class AimalDetails extends StatelessWidget {
  const AimalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.color4,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration:
                BoxDecoration(color: ColorApp.color2, shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back,
              color: ColorApp.color4,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 30, bottom: 20),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image(
              image: AssetImage('assets/images/sara.png'),
              fit: BoxFit.fill,
            ),
          ),
          text(
            text1: 'Name :',
            color: ColorApp.color2,
            size: 20,
          ),
          SizedBox(
            height: 20,
          ),
          text(
            text1: 'Age :',
            color: ColorApp.color2,
            size: 20,
          ),
          SizedBox(
            height: 20,
          ),
          text(
            text1: 'Type :',
            color: ColorApp.color2,
            size: 20,
          ),
          SizedBox(
            height: 20,
          ),
          text(
            text1: 'Date :',
            color: ColorApp.color2,
            size: 20,
          ),
        ],
      ),
    );
  }
}
