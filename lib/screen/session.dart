import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/colors.dart';
import '../components/defaultButton.dart';
import '../components/text.dart';
import '../cubits/User/cubit.dart';
import '../cubits/User/state.dart';

class session extends StatefulWidget {


  @override
  State<session> createState() => _sessionState();
}

class _sessionState extends State<session> {

  void initState() {
    super.initState();
    UserCubit.get(context).all_session();
    UserCubit.get(context).user_session();
    UserCubit.get(context).type_select(UserCubit.get(context).select);
  }

  late String select = '';

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<UserCubit,UserSates>(
      listener: ( context, state) {  },
      builder: (context, state) {

        return Scaffold(
            appBar: AppBar(title: text(text1:" Sessions",color: ColorApp.color2,
              size: 22,),
              leading: IconButton(onPressed: () {
                Navigator.pop(
                    context);
              }, icon: Icon(Icons.arrow_back_ios),),),

            body:
            (    UserCubit.get(context)
                .sessionmodel==null)?

            Center(child: CircularProgressIndicator())
            :
             Padding(
              padding: const EdgeInsets.all(8.0),
              child:

              Column(
                children: [
                  Container(
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultButton(
                              onTap: () {
                                select = "all";
                                UserCubit
                                    .get(context)
                                    .type_select("all");
                              },
                              w: 140,
                              text: "All ",
                              textColor: UserCubit.get(context).f_gender,
                              color: ColorApp.color4),
                          SizedBox(width: 10),
                          defaultButton(
                            onTap: () {
                              UserCubit.get(context).type_select("your");
                              select = "your";
                            },
                            text: "your",
                            textColor: UserCubit.get(context).m_gender,
                            color: ColorApp.color4,
                            w: 140,
                          ),
                        ],
                      ),
                    ),
                  ),
                  (UserCubit.get(context).select=="all")?

                     Expanded(
                      child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: 1.5,
                        children: List.generate(
                          UserCubit.get(context)
                              .sessionmodel!
                              .data
                              .length,
                              (index) => builditem(
                              UserCubit.get(context)
                                  .sessionmodel!
                                  .data[index],
                              context,
                              index),
                        ),
                      ))
                      :
                  Expanded(
                      child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: 1.5,
                        children: List.generate(
                          UserCubit.get(context)
                              .session_user!
                              .data
                              .length,
                              (index) => you_builditem(
                              UserCubit.get(context)
                                  .session_user!
                                  .data[index],
                              context,
                              index),
                        ),
                      )),
                ],
              ),


            )
                
        );
      },);
  }

  Widget builditem(dynamic model, context, index) {

    final screenWidth = MediaQuery.of(context).size;

    return Container(
      height: 400,
      width: 520,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
        // shadowColor:Colors.black,
        surfaceTintColor: ColorApp.color2,

        borderOnForeground: false,

        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
                color: ColorApp.colorback,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8,left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0,left: 25),
                        child: text(
                          text1: "Subject : ${model!.title}",
                          size: 18,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0,left: 25),
                        child: Row(
                          children: [

                            text(
                              text1: " the time : ",
                              size: 18,
                              fontWeight: FontWeight.w100,
                            ),
                            text(
                              text1: " ${model.time} ",
                              size: 16,
                              fontWeight: FontWeight.normal,
                            ),
                            text(
                              text1: " in ",
                              size: 18,
                              fontWeight: FontWeight.normal,
                            ),
                            text(
                              text1: " ${model.date.year}-${model.date.month}-${model.date.day} ",
                              size: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ),
                      // text(
                      //   text1: " the Date : ${model.updatedAt.year}-${model.updatedAt.month}-${model.updatedAt.day}",
                      //   size: 16,
                      //   fontWeight: FontWeight.normal,
                      // ),

                      model.isAdded==false?
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: defaultButton(onTap: (){
                            UserCubit.get(context).session_P(session_id: model.id);
                            UserCubit.get(context).all_session();
                            UserCubit.get(context).user_session();

                          },text: "Join the Session",w:screenWidth.width-120,fontweight: FontWeight.w100,
                            h: 50,s: 18,),
                        ),
                      )
                          :
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: defaultButton(onTap: (){
                          },text: "Already Joined ",w:screenWidth.width-120,fontweight: FontWeight.normal,
                            h: 50,s: 18,),
                        ),
                      )
                    
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget you_builditem(dynamic model, context, index) {

    final screenWidth = MediaQuery.of(context).size;

    return Container(
      height: 400,
      width: 520,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
        // shadowColor:Colors.black,
        surfaceTintColor: ColorApp.color2,

        borderOnForeground: false,

        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                color: ColorApp.colorback,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, right: 18,left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text(
                        text1: "Subject  : ${model!.session.title}",
                        size: 16,
                        fontWeight: FontWeight.w200,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [

                          text(
                            text1: " the time : ",
                            size: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          text(
                            text1: " ${model.session.time} ",
                            size: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          text(
                            text1: "  in ",
                            size: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          text(
                            text1: "  ${model.session.date.year}-${model.session.date.month}-${model.session.date.day} ",
                            size: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),



                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
