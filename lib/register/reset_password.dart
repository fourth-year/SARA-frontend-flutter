import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits_register/cubit.dart';
import 'package:sara_front/cubits_register/states.dart';

class reset_passwore extends StatefulWidget {
  reset_passwore({required this.code});
  String code;

  @override
  State<reset_passwore> createState() => _reset_passworeState();
}

class _reset_passworeState extends State<reset_passwore> {
  bool passError=false;

  var passwordcontroller=TextEditingController();

  var c_passwordcontroller=TextEditingController();

  var formkay =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<registerCubit,registerSates>(
        listener: ( context,  state) {
          if(state is ResetSuccessState){
            print('reset done');
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
                            image: AssetImage("assets/images/Reset password.png"),
                            height: 220,),
                          SizedBox(height: 15,),
                          text(text1: 'Create New Password',
                            size: 25,
                            font: "title",
                            fontWeight: FontWeight.w100,
                            color: ColorApp.color2,),

                          SizedBox(height: 4,),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,right: 18,left: 18),
                            child: text(
                              text1: 'create new password  and please never shere it with anyone for safe use.',
                              size: 15,
                              fontWeight: FontWeight.normal,),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0,right: 18.0,bottom: 5.0),
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
                          passError
                              ? Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                text(
                                  text1: 'this field must contain at least 8 characters',color: ColorApp.color2,size: 12,fontWeight: FontWeight.w100,
                                ),
                              ],
                            ),
                          )
                              :SizedBox(height: 10,),

                          Padding(
                            padding: const EdgeInsets.only(left: 18.0,right: 18.0,bottom: 5.0,top: 10),
                            child: textfromfilde(hint:'Confirm  Password',
                              controller: c_passwordcontroller,
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
                          passError
                              ? Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                text(
                                  text1: 'this field must contain at least 8 characters',color: ColorApp.color2,size: 12,fontWeight: FontWeight.w100,
                                ),
                              ],
                            ),
                          )
                          :SizedBox(height: 10,),
                           ConditionalBuilder(
                            condition:state is! ResetLoadingState,
                            fallback: (context)=>Center(child: CircularProgressIndicator(),),
                            builder: (BuildContext context) =>
                                 Padding(
                                   padding: const EdgeInsets.only(top: 10.0),
                                   child: defaultButton(
                                          onTap: () {
                                            if (formkay.currentState!
                                                .validate()) {
                                              if ((passwordcontroller.text
                                                  .length > 7 &&
                                                  c_passwordcontroller.text
                                                      .length > 7)) {
                                                setState(() {
                                                  passError = false;
                                                });
                                                registerCubit.get(context)
                                                    .resetpassword(
                                                    code: widget.code,
                                                    password: passwordcontroller
                                                        .text,
                                                    c_password: c_passwordcontroller
                                                        .text);
                                              }
                                            else setState(() {
                                            passError = true;});
                                          }
                                          },
                                                                   text: "Update Password",
                                                                   w: 180,
                                                                   h: 45,
                                                                   r: 10,
                                                                   s: 18,
                                                                   color: ColorApp.color2),
                                 ),
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
