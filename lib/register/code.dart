import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textButton.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits_register/cubit.dart';
import 'package:sara_front/cubits_register/states.dart';

import 'reset_password.dart';


class code extends StatelessWidget {
  code({required this.email});
  String email;
  var codecontroller=TextEditingController();
  var formkay =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<registerCubit,registerSates>(
      listener: (BuildContext context, state) {  
        if(state is CodeSuccessState){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>reset_passwore(code: codecontroller.text),));
          
        }
        
      },
      builder: (BuildContext context, state) {
        return   Scaffold(
      backgroundColor: ColorApp.colorback,
      body: SingleChildScrollView(
      child:  Form(
      key: formkay,
      child: Column(

      children: [
      SizedBox(height: 100),
      Image(
      image: AssetImage("assets/images/Forgot password.png"),height: 200,),
      SizedBox(height: 15,),
      text(text1: 'Enter Code ',size: 30,font: "title",
      fontWeight: FontWeight.w100,
      color: ColorApp.color2,),
      // text(text1: 'please enter your email address to search for your account ',),

      SizedBox(height: 4,),
      Padding(
      padding: const EdgeInsets.all(10.0),
      child: text(text1: 'please enter Code sent to ${email}  ',size: 15,fontWeight: FontWeight.normal,),
      ),
      SizedBox(height: 20,),
      Padding(
      padding: const EdgeInsets.only(left: 18.0,right: 18.0,bottom: 18.0),
      child: textfromfilde(hint:'Code*',
      controller:codecontroller ,
      color: ColorApp.color,
      validate: (value) {
      if (value == null || value.isEmpty) {
      return "please enter code";
      }
      return null;
      },
      ),
      ),
      ConditionalBuilder(
      condition:state is! CodeLoadingState,
      fallback: (context)=>Center(child: CircularProgressIndicator(),),
      builder: (BuildContext context) =>defaultButton(
       onTap: (){
            registerCubit.get(context).codecheke(code: codecontroller.text);
              },
      text: "Submit", w: 130,
      h: 45,
      r:10 ,
      s: 20,
      color:ColorApp.color2),
      ),
      Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Center(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      text(text1: "Not Receive Code?",size: 14,fontWeight: FontWeight.w100,color: Colors.black45,),
      textButton(
      text: "Resend",
      onTap: (){
      })
      ],
      ),),
      )


      ]
      ),
        )
        )
        );
        },

    );
  }
}
