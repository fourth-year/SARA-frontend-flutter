import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textButton.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/register/cubit.dart';
import 'package:sara_front/cubits/register/states.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/register/signup.dart';
import 'package:sara_front/screen/layout.dart';
import '../network/end_point.dart';
import 'forget.dart';

class signin extends StatelessWidget {

  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var formkay =GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldekey= new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size;

    return BlocConsumer<registerCubit,registerSates>(
      listener: ( context,  state) {
            if (state is LoginSuccessState){
              CachHelper.savetoken(key: 'token', value: state.loginModel.token.toString()).then((value) {
                token=CachHelper.gettoken(key: "token");
                print ('save token');
                CachHelper.saveData(key: "role_id", value: state.loginModel.user.role.toString());
                role_id=CachHelper.getData(key: "role_id");
                CachHelper.savetoken(key: 'name', value: state.loginModel.user.name.toString());
                  CachHelper.savetoken(key: 'address', value: state.loginModel.user.address.toString());
                    CachHelper.savetoken(key: 'phone', value: state.loginModel.user.phone.toString());
                      CachHelper.savetoken(key: 'email', value: state.loginModel.user.email.toString());
                        CachHelper.savetoken(key: 'photo', value: state.loginModel.user.photo.toString());
                        CachHelper.saveData(key: 'id', value: state.loginModel.user.id.toString());

                CachHelper.savetoken(key: 'gender', value: state.loginModel.user.gender.toString());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(
                    children: [
                      Text(
                        'You have successfully logged in'.tr(),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(), // Add a spacer to push the icon to the end
                      Icon(Icons.check, color: Colors.green),
                    ],
                  ),
                  behavior: SnackBarBehavior.floating,
                  // showCloseIcon: true,
                  // closeIconColor: Colors.black,
                  backgroundColor: ColorApp.colorback,
                ));
                Navigator.push(context,MaterialPageRoute(builder: (context) => Layout(),));

            }
              );}


            if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Please ensure of the entered information'.tr(),
                  style: TextStyle(
                    color: ColorApp.color2,
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                showCloseIcon: true,
                closeIconColor: ColorApp.color2,
                backgroundColor: ColorApp.colorback,
              ));
            }


      },
      builder: ( context, state) {
        return  Scaffold(
          key: scaffoldekey,
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
                      height: 180,
                      width:screenWidth.width,
                      constraints: BoxConstraints(),
                      decoration: BoxDecoration(

                          image: DecorationImage(

                              image: AssetImage('assets/images/p1.jpg',),
                              fit: BoxFit.cover)
                      ),

                    ),
                  ),
                  SizedBox(height: 35,),
                  text(text1: 'Welcome Back'.tr(),size: 35,font: "title",
                    fontWeight: FontWeight.w100,
                    themestyle: Theme.of(context).textTheme.headline3,
                    color: ColorApp.color2,),
                  SizedBox(height: 4,),
                  text(text1: 'Login to your account'.tr(),size: 15,fontWeight: FontWeight.normal,
                    themestyle: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18.0,bottom: 18.0),
                    child: textfromfilde(hint:'Your Email'.tr(),
                      controller:emailcontroller ,
                      color: ColorApp.color,
                      prefix: Icon(Icons.person),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your email or phone".tr();
                        }



                            return null;

                        },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18.0,bottom: 8.0),
                    child: textfromfilde(hint:'Your Password'.tr(),
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
                          return "please enter your password".tr();
                        }
    else {
    if (passwordcontroller.text.length < 8) {
    return "this field must contain at least 8 characters".tr();
    }}
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      textButton(text: "forgot password?".tr(), onTap:() {
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
                          text: "Sign In".tr(),
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
                      text(text1: "Don't have an account?".tr(),size: 14,themestyle: Theme.of(context).textTheme.subtitle1,),
                      textButton(
                          text: "Sign Up".tr(),
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