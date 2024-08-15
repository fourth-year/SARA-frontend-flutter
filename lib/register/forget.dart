import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/register/cubit.dart';
import 'package:sara_front/cubits/register/states.dart';
import 'package:sara_front/register/code.dart';


class forgetPassword extends StatelessWidget {

  var emailcontroller=TextEditingController();
  var formkay =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<registerCubit,registerSates>(
        listener: ( context,  state) {
          if(state is ForgetSuccessState){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) =>code(email: emailcontroller.text),));  
          }


        },

        builder: ( context, state)
    {
      return Scaffold(
          backgroundColor: ColorApp.colorback,
          body: SingleChildScrollView(
              child: Form(
                key: formkay,
                child: Column(

                    children: [
                      SizedBox(height: 80,),
                      Image(
                        image: AssetImage("assets/images/Forgot password.png"),
                        height: 200,),
                      SizedBox(height: 15,),
                      text(text1: 'Find Your Account'.tr(),
                        size: 30,
                        font: "title",
                        fontWeight: FontWeight.w100,
                        color: ColorApp.color2,),
                      // text(text1: 'please enter your email address to search for your account ',),

                      SizedBox(height: 4,),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,right: 18,left: 18),
                        child: text(
                          text1: 'please enter your email address to search for your account'.tr(),
                          size: 15,
                          fontWeight: FontWeight.normal,),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, bottom: 18.0),
                        child: textfromfilde(hint: 'Your Email  '.tr(),
                          controller: emailcontroller,
                          color: ColorApp.color,
                          prefix: Icon(Icons.email_rounded),
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter your email".tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      ConditionalBuilder(
                        condition:state is! ForgetLoadingState,
                        fallback: (context)=>Center(child: CircularProgressIndicator(),),
                        builder: (context) =>defaultButton(
                          text: "Search".tr(),
                          w: 130,
                          h: 45,
                          r: 10,
                          s: 20,
                          color: ColorApp.color2,
                          onTap: () {
                          registerCubit.get(context).forgetpaassword(email: emailcontroller.text);
                          // Navigator.push(context,MaterialPageRoute(builder: (context) => code(email: "xcvgbhn"),));

                        },),
                      ),


                    ]
                ),
              )
          )
      );
    }
    );



  }
}
