import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/textButton.dart';

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
    return BlocConsumer<UserCubit, UserSates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: text(
                text1: "Sessions".tr(),
                themestyle: Theme.of(context).textTheme.headline5,

                color: ColorApp.color2,
                size: 22,
              ),
              leading: IconButton(onPressed: () {
                Navigator.pop(context);

              }, icon: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Icon(Icons.arrow_back_ios),
              ),),
            ),
            body: (UserCubit.get(context).sessionmodel == null)
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
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
                                      UserCubit.get(context).type_select("all");
                                    },
                                    w: 140,
                                    text: "All ".tr(),
                                    textColor: UserCubit.get(context).f_gender,
                                    color: ColorApp.color4),
                                SizedBox(width: 10),
                                defaultButton(
                                  onTap: () {
                                    UserCubit.get(context).type_select("your");
                                    select = "your";
                                  },
                                  text: "your".tr(),
                                  textColor: UserCubit.get(context).m_gender,
                                  color: ColorApp.color4,
                                  w: 140,
                                ),
                              ],
                            ),
                          ),
                        ),
                        (UserCubit.get(context).select == "all")
                            ?
                        Expanded(
                          child: ListView.builder(
                            itemCount:  UserCubit.get(context)
                                .sessionmodel!
                                .data
                                .length,
                            itemBuilder: (context, index) {
                              return  builditem(
                                  UserCubit.get(context)
                                      .sessionmodel!
                                      .data[index],
                                  context,
                                  index);
                            },
                          ),
                        )

                            :
                        Expanded(
                          child: ListView.builder(
                            itemCount: UserCubit.get(context)
                                .session_user!
                                .data
                                .length,
                            itemBuilder: (context, index) {
                              return  you_builditem(
                                  UserCubit.get(context)
                                      .session_user!
                                      .data[index],
                                  context,
                                  index);
                            },
                          ),
                        )




                      ],
                    ),
                  ));
      },
    );
  }

  Widget builditem(dynamic model, context, index) {
    final screenWidth = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8,top:20),
      child: Card(

        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        // shadowColor:Colors.black,
        surfaceTintColor: ColorApp.color2,

        borderOnForeground: false,

        child: Container(
          decoration: BoxDecoration(
            color:
            Theme.of(context).brightness == Brightness.light
                ? ColorApp.colorback// لون المظهر الخفيف
                : Colors.grey[800] ?? ColorApp.color2,
            borderRadius: BorderRadius.circular(20)
          ),

          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25),
                    child: text(
                      text1: " ${model!.title}",
                      size: 18,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25),
                    child: Row(
                      children: [
                        text(
                          text1: " the time : ".tr(),
                          size: 18,
                          fontWeight: FontWeight.w100,
                        ),
                        text(
                          text1: " ${model.time} ",
                          size: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        text(
                          text1: " in ".tr(),
                          size: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        text(
                          text1:
                              " ${model.date.year}-${model.date.month}-${model.date.day} ",
                          size: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                 SizedBox(height: 5,),
                  model.isAdded == false
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                          Container(
                              width: double
                                  .infinity, // Take up the full width of the screen
                              alignment: Alignment.center,
                              child: textButton(
                                text: "Join the Session".tr(),
                                size: 18,
                                onTap: () {
                                  UserCubit.get(context)
                                      .session_P(session_id: model.id);
                                  UserCubit.get(context).all_session();
                                  UserCubit.get(context).user_session();
                                },
                                color: Colors.green,
                              ),
                            ),
                        ],
                      )

                      :Container(
                    width: double
                        .infinity, // Take up the full width of the screen
                    alignment: Alignment.center,
                    child: textButton(
                      text: "Already Joined".tr(),
                      size: 18,
                      onTap: () {},
                      color: Colors.grey,
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget you_builditem(dynamic model, context, index) {
    final screenWidth = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8,top:25),
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        // shadowColor:Colors.black,
        surfaceTintColor: ColorApp.color2,

        borderOnForeground: false,

        child: Container(
          decoration: BoxDecoration(
            color:
            Theme.of(context).brightness == Brightness.light
                ? ColorApp.colorback// لون المظهر الخفيف
                : Colors.grey[800] ?? ColorApp.color2,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25),
                    child: text(
                      text1: "${model!.session.title}",
                      size: 18,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25),
                    child: Row(
                      children: [
                        text(
                          text1: " the time : ".tr(),
                          size: 18,
                          fontWeight: FontWeight.w100,
                        ),
                        text(
                          text1: " ${model.session.time} ",
                          size: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        text(
                          text1: " in ".tr(),
                          size: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        text(
                          text1:
                          " ${model.session.date.year}-${model.session.date.month}-${model.session.date.day} ",
                          size: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );


    // return Padding(
    //   padding: const EdgeInsets.only(left: 30.0,right: 30,top:8),
    //   child: Card(
    //     elevation: 3.0,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(24.0),
    //     ),
    //     // shadowColor:Colors.black,
    //     surfaceTintColor: ColorApp.color2,
    //
    //     borderOnForeground: false,
    //
    //     child: Padding(
    //       padding: const EdgeInsets.all(7.0),
    //       child: Row(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 text(
    //                   text1: "Subject  : ${model!.session.title}",
    //                   size: 16,
    //                   fontWeight: FontWeight.w200,
    //                 ),
    //                 SizedBox(
    //                   height: 5.0,
    //                 ),
    //                 Row(
    //                   children: [
    //                     text(
    //                       text1: " the time : ",
    //                       size: 18,
    //                       fontWeight: FontWeight.normal,
    //                     ),
    //                     text(
    //                       text1: " ${model.session.time} ",
    //                       size: 16,
    //                       fontWeight: FontWeight.normal,
    //                     ),
    //                     text(
    //                       text1: "  in ",
    //                       size: 18,
    //                       fontWeight: FontWeight.normal,
    //                     ),
    //                     text(
    //                       text1:
    //                           "  ${model.session.date.year}-${model.session.date.month}-${model.session.date.day} ",
    //                       size: 16,
    //                       fontWeight: FontWeight.normal,
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
