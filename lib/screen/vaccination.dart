import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/screen/Jops.dart';
import '../components/textButton.dart';
import '../cubits/cubits_animals/cubit.dart';
import '../cubits/cubits_animals/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../components/colors.dart';
import '../components/text.dart';
import 'layout.dart';

class vaccination extends StatefulWidget {
  @override
  State<vaccination> createState() => _vaccinationState();
}

class _vaccinationState extends State<vaccination> {
  // GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();
  // GlobalKey<ScaffoldState> _scaffoldKeyVac = GlobalKey<ScaffoldState>();
  // GlobalKey<ScaffoldState> _scaffoldKeyElse = GlobalKey<ScaffoldState>(); // new key

  void initState() {
    super.initState();
    AnimalCubit.get(context).vaccinationAnimal();
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimalCubit, AnimalStates>(
      listener: (context, state) {
        if (state is CanvaccinationErrorState) {
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Error happened, try again'.tr(),
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
            AnimalCubit.get(context).feedingAnimal();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => vaccination()));
          }
        }
        if (state is CanvaccinationSuccessState) {
          AnimalCubit.get(context).vaccinationAnimal();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => vaccination()),
          );
        }
      },
      builder: (context, state) {
        if (AnimalCubit.get(context).vaccination_modle != null) {
          print('vaccination');
          return Scaffold(
            // key: _scaffoldKeyVac,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Layout()),
                  );
                },
                icon: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
              title: text(
                themestyle: Theme.of(context).textTheme.headline5,

                text1: 'Vaccination'.tr(),
                color: ColorApp.color2,
                size: 22,
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: 2.5,
                    children: List.generate(
                      AnimalCubit.get(context).vaccination_modle!.data.length,
                      (index) => builditem(
                          AnimalCubit.get(context)
                              .vaccination_modle!
                              .data[index],
                          context,
                          index),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          print('not vaccination');
          return Scaffold(
              // key: _scaffoldKeyElse,

              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Layout()),
                    );
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
                title: text(
                  themestyle: Theme.of(context).textTheme.headline5,

                  text1: 'Vaccination'.tr(),
                  color: ColorApp.color2,
                  size: 22,
                ),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }

  Widget builditem(dynamic model, context, index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        // height: 400,
        // width: 520,
        child: Card(
          // elevation: 3.0,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(20.0),
          // ),
          // // shadowColor:Colors.black,
          // surfaceTintColor: ColorApp.color2,
          //
          // borderOnForeground: false,

          child: Container(
            decoration: BoxDecoration(
                // color: ColorApp.colorback,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text(
                              text1: "Name :".tr()+"${model!.name}".tr(),
                              size: 20,
                              fontWeight: FontWeight.w200,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            text(
                              text1: "the time  : ".tr(),
                              size: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GestureDetector(
                    onTap: () {
                      dynamic dep;
                      dep= AnimalCubit.get(context).departmentMap!.keys.firstWhere((key) =>
                      AnimalCubit.get(context).departmentMap?[key] == model.name );
                      // if (model.name == "Department 1".tr()) {
                      //   dep = 1;
                      // }
                      // if (model.name == "Department 2".tr()) {
                      //   dep = 2;
                      // }
                      // if (model.name == "Department 3".tr()) {
                      //   dep = 3;
                      // }
                      // if (model.name == "Department 4".tr()) {
                      //   dep = 4;
                      // }
                      // if (model.name == "Department 5".tr()) {
                      //   dep = 5;
                      // }
                      // if (model.name == "Department 6".tr()) {
                      //   dep = 6;
                      // }
                      // if (model.name == "Department 7".tr()) {
                      //   dep = 7;
                      // }
                      // if (model.name == "Department 8".tr()) {
                      //   dep = 8;
                      // }
                      // if (model.name == "Department 9".tr()) {
                      //   dep = 9;
                      // }
                      // if (model.name == "Department 10".tr()) {
                      //   dep = 10;
                      // }

                      openFeedingDialog(context, dep);
                      print(model.name);
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////
  openFeedingDialog(BuildContext context, dynamic i) {
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
            content: Padding(
              padding: const EdgeInsets.all(5.0),
              child: text(
                text1: 'Are you sure you can complete the task?'.tr(),
                color: ColorApp.color2,
              ),
            ),
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
                  text: 'yes'.tr(),
                  color: ColorApp.color2,
                  onTap: () {
                    AnimalCubit.get(context).Can_vaccination(id_dep: i);
                    // Navigator.push(context, MaterialPageRoute(builder:(context)=> vaccination()));
                  })
            ],
          ),
        );
      },
    );
  }
}
