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
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/register/signup.dart';

import 'forget.dart';

class signin extends StatelessWidget {

  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var formkay =GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<registerCubit,registerSates>(
      listener: ( context,  state) {
            if (state is LoginSuccessState){
              CachHelper.savetoken(key: 'token', value: state.loginModel.token.toString()).then((value) {
                print ('save token');
                // Navigator.push(context,MaterialPageRoute(builder: (context) => home(),));

            }
              );}
      },
      builder: ( context, state) { return  Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 750,
            decoration: BoxDecoration(
              color:ColorApp.colorback,

            ),

            child: Form(
              key: formkay,
              child: Column(

                children: [
                  ClipPath(
                    clipper: containerclipper(),
                    child: Container(
                      height: 250,
                      width:600,
                      constraints: BoxConstraints(),
                      decoration: BoxDecoration(

                          image: DecorationImage(

                              image: AssetImage('assets/images/p1.jpg',),
                              fit: BoxFit.cover)
                      ),

                    ),
                  ),
                  SizedBox(height: 15,),
                  text(text1: 'Welcome Back',size: 35,font: "title",
                    fontWeight: FontWeight.w100,
                    color: ColorApp.color2,),
                  SizedBox(height: 4,),
                  text(text1: 'Login to your account',size: 15,fontWeight: FontWeight.normal,),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18.0,bottom: 18.0),
                    child: textfromfilde(hint:'Your Email or Your Phone ',
                      controller:emailcontroller ,
                      color: ColorApp.color,
                      prefix: Icon(Icons.person),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your email or your phone";
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18.0,bottom: 8.0),
                    child: textfromfilde(hint:'Your Password',
                      controller: passwordcontroller,
                      color: ColorApp.color,
                      prefix: Icon(Icons.lock_rounded),
                      type: TextInputType.visiblePassword,

                      obscure:  registerCubit.get(context).ispassword,
                      suffixPressed: (){
                        registerCubit.get(context).changpassword();
                      },
                      suffix: registerCubit.get(context).suffix,

                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password";
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      textButton(text: "forgot password?", onTap:() {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => forgetPassword(),));
                      }),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: ConditionalBuilder(
                        condition:state is! LoginLoadingState,
                        fallback: (context)=>Center(child: CircularProgressIndicator(),),
                        builder: (context)=>  defaultButton(
                          text: "Sign In",
                          w: 130,
                          h: 45,
                          r:10 ,
                          s: 20,
                          color:ColorApp.color2,
                          onTap: (){

                            if (formkay.currentState!.validate())
                            {
                              registerCubit.get(context).userlogin(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text
                              );

                            }
                            else  print('oops');
                          },


                          // Color.fromRGBO(255, 239, 193,1),
                        ),

                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text(text1: "Don't have an account?",size: 14,),
                      textButton(
                          text: "Sign Up",
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => signup(),));


                          })
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      );
      },


    );
          }
        }


        class containerclipper extends CustomClipper<Path>{

          @override
          Path getClip(Size size) {
            var path=Path();
            var h=size.height;
            var w=size.width;
            path.moveTo(0, 0 );
            path.lineTo(0, h);
            path.quadraticBezierTo(w*0.3,h *0.98, w*0.50, h*0.8);
            path.quadraticBezierTo(w*0.8, h*0.7,w,h);
            path.lineTo(w,0);
            path.close();
            //throw UnimplementedError();
            return path;
          }

          @override
          bool shouldReclip(covariant CustomClipper oldClipper) {
            // TODO: implement shouldReclip
            return false;
            // throw UnimplementedError();
          }



        }