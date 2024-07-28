import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/User/cubit.dart';
import 'package:sara_front/cubits/User/state.dart';
import 'package:sara_front/screen/drawer.dart';
import 'package:sara_front/screen/layout.dart';

import '../components/colors.dart';
import '../components/defaultButton.dart';
import '../components/text.dart';
import '../components/textButton.dart';

class donation extends StatelessWidget {
  var amountcontroller=TextEditingController();
  var amountc_controller=TextEditingController();
  var formkay =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserSates>(
      listener: (BuildContext context, UserSates state) {
        if (state is DonationSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: text(text1: ' Donation successfully,',),
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
            closeIconColor: Colors.black,
            backgroundColor: ColorApp.colorback,
          ));
        }

        if (state is DonationErrorState) {
         mesErorrDialog(context, state.mes);

          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text(
          //     'Donation failed,',
          //     style: TextStyle(
          //       color: ColorApp.color2,
          //       fontFamily: 'Inter',
          //       fontSize: 15,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          //   behavior: SnackBarBehavior.floating,
          //   showCloseIcon: true,
          //   closeIconColor: ColorApp.color2,
          //   backgroundColor: ColorApp.colorback,
          // ));
        }



      },
      builder: (BuildContext context, UserSates state) {
        return  Scaffold(
          appBar: AppBar(title: text(text1:"Donation",size: 22,
            color: ColorApp.color2,
          ),
            leading: IconButton(onPressed: () {
              Navigator.pop(
                context);
            }, icon: Icon(Icons.arrow_back_ios),),),
          body: Form(
            key: formkay,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 40.0,right: 40.0,bottom: 40.0),
                    child: text(text1:"You can make a difference in the lives of animals by donating to the center here. By doing so, "
                        "you will help support our work to uplift animals and improve their lives, "
                        "no matter how small the donation",size: 15,),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18.0,bottom: 25.0),
                    child: textfromfilde(hint:'enter the amount ',
                      controller:amountcontroller ,
                      color: ColorApp.color,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter the amount";
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: ConditionalBuilder(
                        condition:state is! DonationLoadingState,
                        fallback: (context)=>Center(child: CircularProgressIndicator(),),
                        builder: (context)=>  defaultButton(
                          text: " Done",
                          w: 130,
                          h: 45,
                          r:10 ,
                          s: 20,
                          color:ColorApp.color2,
                          onTap: (){

                            if (formkay.currentState!.validate())
                            {
                                UserCubit.get(context).post_donation(balance: int.parse(amountcontroller.text));
                            }

                          },


                          // Color.fromRGBO(255, 239, 193,1),
                        ),

                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }


  mesErorrDialog(BuildContext context,String mes ) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: AlertDialog(
            backgroundColor: ColorApp.colorback,
            content: text( text1: '${mes}',),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            actions: [
              Center(
                child: textButton(
                    text: 'OK'.tr(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>Layout()),);
                    }),
              ),

            ],
          ),
        );
      },
    );
  }
}
