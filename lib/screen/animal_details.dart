import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textButton.dart';
import 'package:sara_front/cubits/cubits_animals/cubit.dart';
import 'package:sara_front/cubits/cubits_animals/states.dart';
import 'package:sara_front/network/end_point.dart';
import 'package:sara_front/screen/layout.dart';
import 'package:sara_front/screen/update_animal.dart';

class AnimalDetails extends StatefulWidget {
  AnimalDetails({super.key,required this.id});
  int id;

  @override
  State<AnimalDetails> createState() => _AnimalDetailsState( id: id);
}

class _AnimalDetailsState extends State<AnimalDetails> {
  _AnimalDetailsState({required this.id});
    int id ;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size;

    return BlocConsumer<AnimalCubit, AnimalStates>(
      listener: (context, state) {
        if (state is DeleteAnimalSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                Text(
                  'Deleted successfully'.tr(),
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
        }

        if (state is DeleteAnimalErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Delete failed'.tr(),
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

        if (state is adoptionsSuccessState){
          adoptionSuccessDialog(context,id);
        }
      },
      builder: (context, state) {
        return Builder(builder: (context) {
          if (AnimalCubit.get(context).get_Animal_By_id!=null) {
            return Scaffold(
              appBar: AppBar(
                  title: text(
                    themestyle: Theme.of(context).textTheme.headline5,
                    text1: 'Animal Details',
                    color: ColorApp.color2,
                    size: 22,
                  ),
                leading: IconButton(
                onPressed: () {

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => Layout()),
                  );
                }, icon: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20),
                  child: Icon(Icons.arrow_back_ios),
                ),),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                      child: Container(
                        // margin: EdgeInsets.only(left: 30, bottom: 20),
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: AnimalCubit.get(context).get_Animal_By_id!.data.photo != null
                            ? Image(height: 75,width: 400,fit: BoxFit.fill,
                          image: MemoryImage(base64Decode(AnimalCubit.get(context).get_Animal_By_id!.data.photo)),
                        )
                            : Image(
                          image: AssetImage('assets/images/sara.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            text(
                              text1: 'Name :'.tr(),
                              color: ColorApp.color2,
                              size: 20,
                              themestyle: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${AnimalCubit.get(context).get_Animal_By_id?.data.name}',
                              style: Theme.of(context).textTheme.headline6,

          )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            text(
                              themestyle: Theme.of(context).textTheme.headline6,

                              text1: 'type :'.tr(),
                              color: ColorApp.color2,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AnimalCubit.get(context).get_Animal_By_id?.data.animaltypeId==1?
                              'Cats'.tr()
                                  :  AnimalCubit.get(context).get_Animal_By_id?.data.animaltypeId==2?
                              "Dogs".tr()
                                  : AnimalCubit.get(context).get_Animal_By_id?.data.animaltypeId==3?
                              "Birds".tr()

                                  : "Horses".tr()

                              ,
                              style:Theme.of(context).textTheme.headline6,

          )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            text(  themestyle: Theme.of(context).textTheme.headline6,

                              text1: 'Age :'.tr(),
                              color: ColorApp.color2,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${AnimalCubit.get(context).get_Animal_By_id?.data.age}',
                              style:Theme.of(context).textTheme.headline6,
          )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                       
                        Row(
                          children: [
                            text(
                              themestyle: Theme.of(context).textTheme.headline6,

                              text1: 'health :'.tr(),
                              color: ColorApp.color2,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${AnimalCubit.get(context).get_Animal_By_id?.data.health}',
                              style: Theme.of(context).textTheme.headline6,

          )
                          ],
                        ),

                        SizedBox(
                          height: 12,
                        ),
                        role_id=="2"?
                        Row(
                          children: [
                            text(
                              themestyle: Theme.of(context).textTheme.headline6,

                              text1: 'Department :'.tr(),
                              color: ColorApp.color2,
                              size: 20,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              AnimalCubit.get(context).get_Animal_By_id?.data.departmentId==1?
                              'Department_1'.tr()
                                  :  AnimalCubit.get(context).get_Animal_By_id?.data.departmentId==2?
                              "Department_2".tr()
                                  : AnimalCubit.get(context).get_Animal_By_id?.data.departmentId==3?
                              "Department_3".tr()
                                  : AnimalCubit.get(context).get_Animal_By_id?.data.departmentId==4?
                              'Department_4'.tr()
                                  :  AnimalCubit.get(context).get_Animal_By_id?.data.departmentId==5?
                              "Department_5".tr()
                                  :  AnimalCubit.get(context).get_Animal_By_id?.data.departmentId==6?
                              'Department_6'
                                  :  AnimalCubit.get(context).get_Animal_By_id?.data.departmentId==7?
                              "Department_7":
                              AnimalCubit.get(context).get_Animal_By_id?.data.departmentId==8?
                              'Department_8'
                                  :  AnimalCubit.get(context).get_Animal_By_id?.data.departmentId==9?
                              "Department_9"
                                  : "Department_10"
                              ,
                              style:Theme.of(context).textTheme.headline6,

          ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        )
                        :SizedBox(),

                        Row(
                          children: [
                            text(
                              themestyle: Theme.of(context).textTheme.headline6,

                              text1: 'Entry Date :'.tr(),
                              color: ColorApp.color2,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${AnimalCubit.get(context).get_Animal_By_id?.data.entryDate.year}-'
                                  '${AnimalCubit.get(context).get_Animal_By_id?.data.entryDate.month}-'
                                  '${AnimalCubit.get(context).get_Animal_By_id?.data.entryDate.day}',
                              style:Theme.of(context).textTheme.headline6,

          )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45, top: 40,right: 45),
                    child:
                    role_id == "2"||role_id == "4"
                        ? Row(
                            children: [
                              defaultButton(
                                w: screenWidth.width/3,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Update_Animal(
                                            id: AnimalCubit.get(context)
                                                .get_Animal_By_id
                                                ?.data
                                                .id)),
                                  );
                                },
                                text: 'Update'.tr(),
                                color: ColorApp.color,
                                textColor: ColorApp.color2,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              defaultButton(
                                  w: screenWidth.width/3,
                                onTap: () {
                                  _openAnimatedDialog(context);
                                },
                                text: 'Delete'.tr(),
                                color: ColorApp.color,
                                textColor: ColorApp.color2,
                              )
                            ],
                          )
                        : AnimalCubit.get(context).get_Animal_By_id!.data.adoptions.isEmpty?
                    Row(
                            children: [
                              defaultButton(
                                onTap: () {
                                  AnimalCubit.get(context).adoptions
                                    (animal_id: AnimalCubit.get(context).get_Animal_By_id!.data.id);
                                },
                                text: 'adoptions'.tr(),
                                color: ColorApp.color,
                                textColor: ColorApp.color2,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              defaultButton(
                                onTap: () {
                                  print(' ffffffffffff');
                                  AnimalCubit.get(context).sponcership(
                                      animal_id: AnimalCubit.get(context).get_Animal_By_id!.data.id, balance: 150000);
                                },
                                text: 'sponcerships'.tr(),
                                color: ColorApp.color,
                                textColor: ColorApp.color2,
                              )
                            ],
                          )
                        :SizedBox(

                    ),
                          // :  defaultButton(
                          // onTap: () {
                          //   AnimalCubit.get(context).sponcership(
                          //       animal_id: AnimalCubit.get(context).get_Animal_By_id!.data.id
                          //       , balance: 150000);
                          //
                          //
                          // },
                          // text: 'sponcerships'.tr(),
                          // color: ColorApp.color3,
                          // textColor: ColorApp.color2,
                          // )
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
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
            content: Text('Are you sure you want to delete this animal?'.tr()),
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
                    AnimalCubit.get(context).DeleteAnimal(
                        id: AnimalCubit.get(context).get_Animal_By_id?.data.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Layout()),
                    );
                  })
            ],
          ),
        );
      },
    );
  }

  sponcershipDialog(BuildContext context, dynamic animal_id) {
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

              ],
            ),
            content: Text('Are you sure you want to delete this animal?'.tr()),
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
                  text: 'done'.tr(),
                  color: ColorApp.color2,
                  onTap: () {
                    AnimalCubit.get(context).getanimal_Byid(id);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>AnimalDetails (id: id,)),);



                  })
            ],
          ),
        );
      },
    );
  }

  adoptionSuccessDialog(BuildContext context,int id ) {
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
            content: Text('Your request has been registered. We will contact you to complete the procedures'),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            actions: [
              Center(
                child: textButton(
                    text: 'OK'.tr(),
                    onTap: () {
                      AnimalCubit.get(context).getanimal_Byid(id);

                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>AnimalDetails (id: id,)),);
                    }),
              ),

            ],
          ),
        );
      },
    );
  }

}
