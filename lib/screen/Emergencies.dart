import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/cubits/Emergencies/cubit/emergency_cubit.dart';
import 'package:sara_front/network/end_point.dart';
import 'package:sara_front/screen/add_emergency.dart';

class Emergencies extends StatelessWidget {
  const Emergencies({super.key});

  @override
  Widget build(BuildContext context) {
    // EmergencyCubit.get(context).getAll_Emergencies(status:1);
    return BlocConsumer<EmergencyCubit, EmergencyState>(
      listener: (context, state) {},
      builder: (context, state) {
        // if (role_id == '1' && state is GetAllEmergenciesSuccessfully) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Emergencies',
              style: TextStyle(fontSize: 20),
            ),
            centerTitle: true,
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
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          // margin: EdgeInsets.only(left: 30, bottom: 20),
                                          width: 120,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.white38,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child:
                                              //  AnimalCubit.get(context)
                                              //             .get_Animal_By_id!
                                              //             .data
                                              //             .photo !=
                                              //         null
                                              // ?
                                              //  ClipRRect(
                                              //   borderRadius: BorderRadius.circular(15),
                                              //    child: Image(
                                              //       height: 150,
                                              //       width: 100,
                                              //       fit: BoxFit.fill,
                                              //       image:
                                              //       //  MemoryImage(base64Decode(
                                              //       //     // AnimalCubit.get(context)
                                              //       //     //     .get_Animal_By_id!
                                              //       //     //     .data
                                              //       //     //     .photo
                                              //       //         )),
                                              //     ),
                                              //  )
                                              // :
                                              ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/sara.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Address:",
                                                  style: TextStyle(
                                                      color: ColorApp.color2,
                                                      fontSize: 18,
                                                      fontFamily: "text normal"),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  child: Text(
                                                    "EmergencyCubit.get(context).get_all_emergencies!.data[index].address ",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Contact:",
                                                  style: TextStyle(
                                                      color: ColorApp.color2,
                                                      fontSize: 18,
                                                      fontFamily: "text normal"),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                FittedBox(
                                                  child: Text(
                                                    " EmergencyCubit.get(context).get_all_emergencies!.data[index].contact",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Animal medical status :",
                                                  style: TextStyle(
                                                      color: ColorApp.color2,
                                                      fontFamily: "text normal",
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                FittedBox(
                                                  child: Text(
                                                    "EmergencyCubit.get(context).get_all_emergencie!.data[index].contact == 1 ? 'Healthy' : EmergencyCubit.get(context)\n.get_all_emergencies!.data[index].contact == 2 ? \'Un Healthy' : 'Under treatment'",
                                                    maxLines: 10,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Description of the emergency situation :",
                                              style: TextStyle(
                                                  color: ColorApp.color2,
                                                  fontFamily: "text normal",
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            FittedBox(
                                              child: Text(
                                                "{EmergencyCubit.get(context).get_all_emergencies!.data[index].description}",
                                                maxLines: 10,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ],
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
                        itemCount: 10
                        // EmergencyCubit.get(context)
                        //     .get_all_emergencies!
                        //     .data
                        //     .length
                        )),
              ],
            ),
          ),
        );
        // } else if (role_id == '4' &&
        //     state is GetAllEmergenciesSuccessfully) {
        //   return Scaffold(
        //     appBar: AppBar(),
        //     // body: Padding(
        //     //   padding: const EdgeInsets.all(10.0),
        //     //   child: Expanded(
        //     //     child: ListView.separated(
        //     //         itemBuilder: (context, index) {},
        //     //         separatorBuilder: (context, index) => SizedBox(
        //     //               height: 10,
        //     //             ),
        //     //         itemCount: EmergencyCubit.get(context)
        //     //             .get_all_Accepted_emergencies?.data.length),
        //     //   ),
        //     // ),
        //   );
        // } else {
        //   return Scaffold(
        //     appBar: AppBar(),
        //     body: Center(
        //       child: Text(
        //         'There are no emergencies',
        //         style: TextStyle(fontSize: 17),
        //       ),
        //     ),
        //   );
        // }
      },
    );
  }
}
