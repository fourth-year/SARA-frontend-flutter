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
  AnimalDetails({super.key, required int id});

  @override
  State<AnimalDetails> createState() => _AnimalDetailsState();
}

class _AnimalDetailsState extends State<AnimalDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimalCubit, AnimalStates>(
      listener: (context, state) {
        if (state is DeleteAnimalSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Deleted successfully',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
            closeIconColor: Colors.black,
            backgroundColor: ColorApp.colorback,
          ));
        }

        if (state is DeleteAnimalErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Delete failed',
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
      },
      builder: (context, state) {
        return Builder(builder: (context) {
          if (state is GetAnimalByIdSuccessState) {
            return Scaffold(
              backgroundColor: ColorApp.color4,
              appBar: AppBar(
                backgroundColor: ColorApp.color4,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, bottom: 20),
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image(
                      image: AssetImage('assets/images/sara.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            text(
                              text1: 'Name :',
                              color: ColorApp.color2,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${AnimalCubit.get(context).get_Animal_By_id?.data.name}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            text(
                              text1: 'Age :',
                              color: ColorApp.color2,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${AnimalCubit.get(context).get_Animal_By_id?.data.age}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            text(
                              text1: 'type :',
                              color: ColorApp.color2,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${AnimalCubit.get(context).get_Animal_By_id?.data.animaltypeId}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            text(
                              text1: 'health :',
                              color: ColorApp.color2,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${AnimalCubit.get(context).get_Animal_By_id?.data.health}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            text(
                              text1: 'Date :',
                              color: ColorApp.color2,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${AnimalCubit.get(context).get_Animal_By_id?.data.entryDate}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60, top: 40),
                    child: role_id == "2"
                        ? Row(
                            children: [
                              defaultButton(
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
                                text: 'Update',
                                color: ColorApp.color3,
                                textColor: ColorApp.color2,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              defaultButton(
                                onTap: () {
                                  _openAnimatedDialog(context);
                                },
                                text: 'Delete',
                                color: ColorApp.color3,
                                textColor: ColorApp.color2,
                              )
                            ],
                          )
                        : Row(
                            children: [
                              defaultButton(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => Update_Animal(
                                  //             id: 3,
                                  //           )),
                                  // );
                                },
                                text: 'k',
                                color: ColorApp.color3,
                                textColor: ColorApp.color2,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              defaultButton(
                                onTap: () {},
                                text: 'f',
                                color: ColorApp.color3,
                                textColor: ColorApp.color2,
                              )
                            ],
                          ),
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
                text(text1: 'Confirmation'),
              ],
            ),
            content: Text('Are you sure you want to delete this animal?'),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            actions: [
              textButton(
                  text: 'Cancel',
                  onTap: () {
                    Navigator.pop(context);
                  }),
              textButton(
                  text: 'Delete',
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
}
