import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textButton.dart';
import 'package:sara_front/cubits/Emergencies/cubit/emergency_cubit.dart';

class AcceptEmergenies extends StatelessWidget {
  const AcceptEmergenies({super.key});

  @override
  Widget build(BuildContext context) {
    EmergencyCubit.get(context).getAll_Emergencies(status: 0);
    return BlocConsumer<EmergencyCubit, EmergencyState>(
      listener: (context, state) {
        if (state is AcceptEmergencySuccessfully) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Successfully accepted',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Color.fromARGB(255, 219, 225, 230),
            ),
          );
        }
        if (state is DeleteEmergencySuccessfully) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Successfully deleted',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Color.fromARGB(255, 219, 225, 230),
            ),
          );
          EmergencyCubit.get(context).getAll_Emergencies(status: 0);
        }
      },
      builder: (context, state) {
        if (state is GetAllEmergenciesSuccessfully) {
          return Scaffold(
            appBar: AppBar(
              title: text(
                text1: 'Unacceptable emergencies',
                size: 18,
                color: ColorApp.color2,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
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
                                              Text(
                                                EmergencyCubit.get(context)
                                                    .get_all_emergencies!
                                                    .data[index]
                                                    .address,
                                                style: TextStyle(fontSize: 15),
                                              ),
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
                                              Text(
                                                EmergencyCubit.get(context)
                                                    .get_all_emergencies!
                                                    .data[index]
                                                    .contact,
                                                style: TextStyle(fontSize: 15),
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
                                          Text(
                                            "${EmergencyCubit.get(context).get_all_emergencies!.data[index].description}",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    _openAnimatedDialog(context,
                                                        id: EmergencyCubit.get(
                                                                context)
                                                            .get_all_emergencies!
                                                            .data[index]
                                                            .id);
                                                  },
                                                  child: Text(
                                                    'Reject',
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 179, 36, 26),
                                                        fontSize: 17),
                                                  )),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    EmergencyCubit.get(context)
                                                        .AcceptEmergency(
                                                            id: EmergencyCubit
                                                                    .get(
                                                                        context)
                                                                .get_all_emergencies!
                                                                .data[index]
                                                                .id);
                                                    EmergencyCubit.get(context)
                                                        .getAll_Emergencies(
                                                            status: 0);
                                                  },
                                                  child: Text(
                                                    'Accept',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 16, 170, 113),
                                                        fontSize: 17),
                                                  ))
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Image.network(
                                          //   "${EmergencyCubit.get(context).get_all_emergencies!.data[index].photo}",
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
        } else if (state is GetAllEmergenciesError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                'There are no unacceptable emergencies',
                style: TextStyle(fontSize: 17),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: CircularProgressIndicator()),
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
                  })
            ],
          ),
        );
      },
    );
  }
}
