import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textButton.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/Posts_cubit/cubit/posts_cubit.dart';
import 'package:sara_front/screen/layout.dart';

class JoinUsPage extends StatefulWidget {
  const JoinUsPage({super.key});

  @override
  State<JoinUsPage> createState() => _JoinUsPageState();
}

class _JoinUsPageState extends State<JoinUsPage> {
  TimeOfDay? selected_start_time;
  TimeOfDay? selected_end_time;
  String? selectstartTime;
  String? selectendTime;
  TextEditingController age = TextEditingController();
  TextEditingController job_title = TextEditingController();
  late TextEditingController start_time = TextEditingController();
  TextEditingController end_time = TextEditingController();

  Future<Null> SelectStartTime(BuildContext context) async {
    final TimeOfDay? selected_start_time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (selected_start_time != null) {
      selectstartTime =
          (selected_start_time.hour < 10 && selected_start_time.minute < 10)
              ? "0${selected_start_time.hour}:0${selected_start_time.minute}:00"
              : "${selected_start_time.hour}:${selected_start_time.minute}:00";
      (selected_start_time.hour < 10 && selected_start_time.minute > 10)
          ? "0${selected_start_time.hour}:${selected_start_time.minute}:00"
          : "${selected_start_time.hour}:${selected_start_time.minute}:00";
      (selected_start_time.hour > 10 && selected_start_time.minute < 10)
          ? "${selected_start_time.hour}:0${selected_start_time.minute}:00"
          : "${selected_start_time.hour}:${selected_start_time.minute}:00";
      (selected_start_time.hour < 10 && selected_start_time.minute < 10)
          ? "${selected_start_time.hour}:${selected_start_time.minute}:00"
          : "${selected_start_time.hour}:${selected_start_time.minute}:00";
      PostsCubit.get(context).selectstartTime(selectstartTime);
      print(selectstartTime);
      start_time.text = selectstartTime.toString();
    }
  }

  Future<Null> SelectEndTime(BuildContext context) async {
    final TimeOfDay? selected_end_time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (selected_end_time != null) {
      selectendTime = (selected_end_time.minute < 10)
          ? "${selected_end_time.hour}:0${selected_end_time.minute}:00"
          : "${selected_end_time.hour}:${selected_end_time.minute}:00";
      PostsCubit.get(context).selectendTime(selectendTime);
      print(selectendTime);
      end_time.text = selectendTime.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is JoinUsSuccess) {
          _openAnimatedDialog(context);
        }
        if (state is JoinUsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Unable to send',
                style: TextStyle(
                  color: Color.fromARGB(255, 59, 1, 1),
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              behavior: SnackBarBehavior.floating,
              showCloseIcon: true,
              backgroundColor: ColorApp.colorback,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Join Us",
              style: TextStyle(color: ColorApp.color2),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(
                    text1:
                        "\"Volunteering is not just about giving time, it's about giving hope and making a difference in the lives of other\"",
                    size: 18,
                    color: ColorApp.color2,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "We are very happy about your interest in joining us.\nPlease enter the required information",
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: textfromfilde(
                      size: 13,
                      hint: 'Enter your age',
                      controller: age,
                      type: TextInputType.name,
                      color: Color.fromARGB(255, 219, 229, 244),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the age";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Tell us a bit about your skills and experience",
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: job_title,
                    minLines: 2,
                    maxLines: 8,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      hintText: 'type...',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.black87),
                      filled: true,
                      fillColor: Color.fromARGB(255, 219, 229, 244),
                      contentPadding: EdgeInsets.only(
                          left: 25, top: 18, bottom: 18, right: 30),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Please specify a time that suits you",
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 230,
                        child: textfromfilde(
                          size: 13,
                          readonly: true,
                          hint: 'Start Time',
                          controller: start_time,
                          type: TextInputType.name,
                          color: Color.fromARGB(255, 219, 229, 244),
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                          },
                          ontap: () {
                            SelectStartTime(context);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 230,
                        child: textfromfilde(
                          size: 13,
                          readonly: true,
                          hint: 'End Time',
                          controller: end_time,
                          type: TextInputType.name,
                          color: Color.fromARGB(255, 219, 229, 244),
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                          },
                          ontap: () {
                            SelectEndTime(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: defaultButton(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          PostsCubit.get(context).add_Request_JoinUs(
                              age: age.text,
                              job_title: job_title.text,
                              start_time:
                                  PostsCubit.get(context).selectstarttime,
                              end_time: PostsCubit.get(context).selectendtime);
                        }
                      },
                      text: "Send",
                      textColor: Colors.white,
                      color: ColorApp.color2,
                      h: 50,
                      w: 100,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _openAnimatedDialog(BuildContext context) {
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
            title: text(text1: 'Thank you'.tr()),
            content: Text(
                'your request has been sent successfully...\nYou will receive an email notification upon approval.'
                    .tr()),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            actions: [
              textButton(
                  text: 'Ok'.tr(),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Layout(),
                        ));
                    age.clear();
                    job_title.clear();
                    start_time.clear();
                    end_time.clear();
                  }),
            ],
          ),
        );
      },
    );
  }
}
