import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/cubits/Emergencies/cubit/emergency_cubit.dart';
import 'package:sara_front/network/end_point.dart';
import 'package:sara_front/screen/add_emergency.dart';
import 'package:sara_front/screen/layout.dart';

import '../components/textButton.dart';
import 'drawer.dart';

class Emergencies extends StatelessWidget {
  const Emergencies({super.key});

  @override
  Widget build(BuildContext context) {
    EmergencyCubit.get(context).getAll_Emergencies(status: 1);
    return BlocConsumer<EmergencyCubit, EmergencyState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (role_id == '1' && EmergencyCubit.get(context).get_all_emergencies!= null) {
          return Scaffold(
            drawer: Drawer_Screen(),
            appBar: AppBar(
              title: Text(
                'Emergencies',
                style: TextStyle(fontSize: 20),
              ),

            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEmergency(),
                    ));
              },
              backgroundColor: ColorApp.color2,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body:Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(left: 30, bottom: 20),
                                        width: 400,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.white38,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                          BorderRadius.circular(15),
                                        ),
                                        child: EmergencyCubit.get(context)
                                            .get_all_emergencies!
                                            .data[index]
                                            .photo !=null
                                            ? ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          child: Image(
                                            width: 400,
                                            height: 200,
                                            fit: BoxFit.fill,
                                            image: MemoryImage(
                                                base64Decode(EmergencyCubit
                                                    .get(context)
                                                    .get_all_emergencies!
                                                    .data[index]
                                                    .photo)),
                                          ),
                                        )
                                            : ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/sara.png'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${EmergencyCubit.get(context).get_all_emergencies!.data[index].emerStatus}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Address:",
                                            style: TextStyle(
                                                color: ColorApp.color2,
                                                fontSize: 16,
                                                fontFamily: "text normal"),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              "${EmergencyCubit.get(context).get_all_emergencies!.data[index]!.address}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                         ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text(
                                            "Contact:",
                                            style: TextStyle(
                                                color: ColorApp.color2,
                                                fontSize: 16,
                                                fontFamily: "text normal"),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            " ${EmergencyCubit.get(context).get_all_emergencies!.data[index].contact}",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Description:",
                                        style: TextStyle(
                                          color: ColorApp.color2,
                                          fontFamily: "text normal",
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${EmergencyCubit.get(context).get_all_emergencies!.data[index].description}",
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                          itemCount: EmergencyCubit.get(context)
                              .get_all_emergencies!
                              .data
                              .length)),
                ],
              ),
            ),
          );
        }
        else if (role_id == '4' && EmergencyCubit.get(context).get_all_emergencies != null) {
          if(EmergencyCubit.get(context).get_all_emergencies!.data.isEmpty ){

            Scaffold(
              appBar: AppBar(),
              body: Center(
                  child: text(text1: "is empty",)
              ),
            );
          }

          return Scaffold(
            drawer: Drawer_Screen(),
            appBar: AppBar(
              title: Text(
                'Emergencies',
                style: TextStyle(fontSize: 20),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(left: 30, bottom: 20),
                                        width: 400,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.white38,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: EmergencyCubit.get(context)
                                                    .get_all_emergencies!
                                                    .data[index]
                                                    .photo !=
                                                null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image(
                                                  width: 400,
                                                  height: 200,
                                                  fit: BoxFit.fill,
                                                  image: MemoryImage(
                                                      base64Decode(EmergencyCubit
                                                              .get(context)
                                                          .get_all_emergencies!
                                                          .data[index]
                                                          .photo)),
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/images/sara.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Spacer(flex: 2,),

                                          Center(
                                            child: Text(
                                              "${EmergencyCubit.get(context).get_all_emergencies!.data[index].emerStatus}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                            ),
                                          ),

                                          Spacer(),

                                          PopupMenuButton(
                                            icon:
                                            Icon(Icons.more_vert_rounded),
                                            onSelected: (value) {
                                              if (value == "In_process") {
                                                EmergencyCubit.get(context)
                                                    .UpdateEmergencyStatus(
                                                    id: EmergencyCubit
                                                        .get(context)
                                                        .get_all_emergencies!
                                                        .data[index]!
                                                        .id,
                                                    emer_status:
                                                    "In_process");
                                                EmergencyCubit.get(context)
                                                    .getAll_Emergencies(
                                                    status: 1);
                                              } else if (value ==
                                                  "processed") {
                                                EmergencyCubit.get(context)
                                                    .UpdateEmergencyStatus(
                                                    id: EmergencyCubit
                                                        .get(context)
                                                        .get_all_emergencies!
                                                        .data[index]!
                                                        .id,
                                                    emer_status:
                                                    "processed");
                                                EmergencyCubit.get(context)
                                                    .getAll_Emergencies(
                                                    status: 1);
                                              }

                                              // if (value == "3")
                                              else {
                                                _openAnimatedDialog(context,
                                                    id: EmergencyCubit.get(
                                                        context)
                                                        .get_all_emergencies!
                                                        .data[index]
                                                        .id);
                                              }
                                            },
                                            itemBuilder: (context) => [
                                              (EmergencyCubit.get(context)
                                                  .get_all_emergencies!
                                                  .data[index]
                                                  .emerStatus ==
                                                  "processed")
                                                  ? PopupMenuItem(
                                                child:
                                                Text('In process'),
                                                value: "In_process",
                                              )
                                                  : PopupMenuItem(
                                                child:
                                                Text('processed'),
                                                value: "processed",
                                              ),
                                              PopupMenuItem(
                                                child: Text('Delete'),
                                                value: "3",
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Address:",
                                            style: TextStyle(
                                                color: ColorApp.color2,
                                                fontSize: 16,
                                                fontFamily: "text normal"),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              "${EmergencyCubit.get(context).get_all_emergencies!.data[index]!.address}",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Contact:",
                                            style: TextStyle(
                                                color: ColorApp.color2,
                                                fontSize: 16,
                                                fontFamily: "text normal"),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            " ${EmergencyCubit.get(context).get_all_emergencies!.data[index].contact}",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Description:",
                                        style: TextStyle(
                                          color: ColorApp.color2,
                                          fontFamily: "text normal",
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${EmergencyCubit.get(context).get_all_emergencies!.data[index].description}",
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 5,
                              ),
                          itemCount: EmergencyCubit.get(context)
                              .get_all_emergencies!
                              .data
                              .length)),
                ],
              ),
            ),
          );
        } else
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator()
            ),
          );
        }
      },
    );
  }

  _openAnimatedDialog(BuildContext context, {required id}) {
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
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, right: 5),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: ColorApp.color2,
                    size: 18,
                  ),
                ),
                text(text1: 'Confirmation'.tr()),
              ],
            ),
            content:
                Text('Are you sure you want to delete this emergency?'.tr()),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            actions: [
              textButton(
                  text: 'Cancel'.tr(),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              textButton(
                  text: 'Delete'.tr(),
                  color: ColorApp.color2,
                  onTap: () {
                    EmergencyCubit.get(context).DeleteEmergency(id: id);

                    // EmergencyCubit.get(context).getAll_Emergencies(status: 1);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Layout(),
                        ));
                  })
            ],
          ),
        );
      },
    );
  }
}
