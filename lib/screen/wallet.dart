import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/User/cubit.dart';
import 'package:sara_front/cubits/User/state.dart';

import '../components/colors.dart';

class Wallet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserSates>(
      listener: (BuildContext context, UserSates state) {  },
      builder: (BuildContext context, UserSates state) {

        if(UserCubit.get(context).walletmodel !=null){
          return  Scaffold(
        appBar: AppBar(backgroundColor: ColorApp.colorback, leading: IconButton(onPressed: () {
          Navigator.pop(context);
          
        }, icon: Icon(Icons.arrow_back_ios),),),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center, // Add this line

              children: [
                text(text1: "You have the following amount in your account :"),
                // Container(
                //   child: textfromfilde(hint: UserCubit.get(context).walletmodel?.data.wallet.toString(),readonly: true,color: Colors.white,color1: Colors.black,),
                //
                // ),
                SizedBox(height: 5,),
                Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  // shadowColor:Colors.black,
                  surfaceTintColor: ColorApp.color2,

                  borderOnForeground: false,
                  child: Container(
                    width: 400,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                    color: Colors.white
                    ),
                    child:Center(child: text(text1: UserCubit.get(context).walletmodel!.data.wallet.toString(),)),

                  ),
                )

              ],),
          ),
        ),


      );}
        return
          Scaffold(
            appBar: AppBar(backgroundColor: ColorApp.colorback, leading: IconButton(onPressed: () {
          Navigator.pop(context);

        }, icon: Icon(Icons.arrow_back_ios),),),
        body: Center(
        child: CircularProgressIndicator(),
        ),
          );
        },
    );
  }
}
