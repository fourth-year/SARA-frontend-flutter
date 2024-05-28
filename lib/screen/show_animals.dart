// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sara_front/cubits/cubits_animals/cubit.dart';
// import 'package:sara_front/cubits/cubits_animals/states.dart';
// import '../components/colors.dart';
// import '../components/text.dart';
//
//
// class Show_Animals extends StatefulWidget {
//   @override
//   State<Show_Animals> createState() => _Show_AnimalsState();
// }
//
// class _Show_AnimalsState extends State<Show_Animals> with SingleTickerProviderStateMixin{
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 5, vsync:this );
//     if (_tabController.indexIsChanging) {
//       setState(() { });
//     }
//     AnimalCubit.get(context).getAllAnimal();
//     AnimalCubit.get(context).getAllCats();
//
//
//   }
//
//
//
//
//   Future<void> fetchAllAnimals(int tabIndex) async {
//     AnimalCubit.get(context).getAllAnimal();
//     AnimalCubit.get(context).getAllCats();
//     return print('done');
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AnimalCubit, AnimalStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           //state is GetAnimalSuccessState||state is GetCatsSuccessState
//           if (AnimalCubit.get(context).allanimals !=null && AnimalCubit.get(context).catsanimals !=null) {
//             print(AnimalCubit.get(context).allanimals?.data.length);
//             return DefaultTabController(
//                 length: 5,
//                 child: Scaffold(
//                   backgroundColor: ColorApp.color,
//                   appBar: AppBar(
//                     backgroundColor: ColorApp.color4,
//                     bottom: TabBar(tabs: [
//                       Tab(child: Text("All"),),
//                       Tab(child: Text("Cats"),),
//                       Tab(child: Text("Dogs"),),
//                       Tab(child: Text("Birds"),),
//                       Tab(child: Text("Horses"),),
//                     ],unselectedLabelColor:Colors.grey[500],
//                         labelColor:ColorApp.color2,
//                         controller: _tabController,
//
//
//                         onTap: (index) {
//                           if (index == 0) {
//                             AnimalCubit.get(context).getAllAnimal();
//                           } else if (index == 1) {
//                             AnimalCubit.get(context).getAllCats();   }
//                         }
//
//                     ),
//
//                   ),
//
//
//                   body:  Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TabBarView(
//                         controller: _tabController,
//                         children: [
//                           Column(
//                             children: [
//                               Expanded(
//                                   child: GridView.count(
//                                     crossAxisCount: 1, childAspectRatio: 5,
//                                     children: List.generate(AnimalCubit
//                                         .get(context)
//                                         .allanimals!.data
//                                         .length, (index) =>
//                                         builditem(AnimalCubit
//                                             .get(context)
//                                             .allanimals!.data[index], context, index),),)),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Expanded(
//                                   child: GridView.count(
//                                     crossAxisCount: 1, childAspectRatio: 5,
//                                     children: List.generate(AnimalCubit
//                                         .get(context)
//                                         .catsanimals!
//                                         .data
//                                         .length, (index) =>
//                                         builditem(AnimalCubit
//                                             .get(context)
//                                             .catsanimals!.data[index], context, index),),)),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Expanded(
//                                   child: GridView.count(
//                                     crossAxisCount: 1, childAspectRatio: 5,
//                                     children: List.generate(AnimalCubit
//                                         .get(context)
//                                         .allanimals!
//                                         .data
//                                         .length, (index) =>
//                                         builditem(AnimalCubit
//                                             .get(context)
//                                             .allanimals!.data[index], context, index),),)),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Expanded(child: GridView.count(crossAxisCount: 1,
//                                 childAspectRatio:5,
//                                 children: List.generate(AnimalCubit.get(context).allanimals!.data.length,
//                                       (index) =>  builditem(AnimalCubit.get(context).allanimals!.data[index], context, index),),),
//
//
//
//
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Expanded(child: GridView.count(crossAxisCount: 1,
//                                 childAspectRatio:2,
//                                 children: List.generate(AnimalCubit.get(context).allanimals!.data.length,
//                                       (index) =>  builditem(AnimalCubit.get(context).allanimals!.data[index], context, index),),),
//
//
//
//
//                               ),
//                             ],
//                           ),
//                         ]),
//                   ),
//                 ));
//
//           } else
//             return Scaffold(
//                 appBar:  AppBar(
//                   backgroundColor: ColorApp.color2,
//                   bottom: TabBar(tabs: [
//                     Tab(child: Text("All"),),
//                     Tab(child: Text("Cat"),),
//                     Tab(child: Text("Dog"),),
//                     Tab(child: Text("Birds"),),
//                     Tab(child: Text("Horses"),),
//                   ],labelColor:Colors.yellow,controller: _tabController,
//                   ),),
//                 body: Center(
//                   child :CircularProgressIndicator(),
//                       // : text(text1: "loading.....",size: 30,),
//                 ));
//         });
//   }
//
//   ////////////////////
//
//   Widget builditem(dynamic model, context, index) {
//
//
//
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: GestureDetector(
//         onTap: (){
//           print(model.id);
//         },
//         child: Container(
//           decoration: BoxDecoration(
//               color: ColorApp.colorback, borderRadius: BorderRadius.circular(30)),
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 10),
//                 child: CircleAvatar(radius: 50, backgroundColor: ColorApp.color2
//                   // NetworkImage(model!.data[index]!.photo.toString()),
//
//                   // MemoryImage(base64Decode(model!.data[index]!.photo)),
//                 ),
//               ),
//               SizedBox(
//                 width: 30.0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0,right: 8,bottom: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     text(
//                       text1: "Name : ${model!.name}",
//                       size: 20,
//                     ),
//                     SizedBox(height: 5.0,),
//                     if(model!.animaltypeId==1)
//                       text(
//                         text1: "Type : Cat",
//                         size: 16,fontWeight: FontWeight.w100,
//                       ),
//                     if(model!.animaltypeId==2)
//                       text(
//                         text1: "Type : Dog",
//                         size: 16,fontWeight: FontWeight.w100,
//                       ),
//                     if(model!.animaltypeId==3)
//                       text(
//                         text1: "Type : Bird",
//                         size: 16,fontWeight: FontWeight.w100,
//                       ),
//                     if(model!.animaltypeId==4)
//                       text(
//                         text1: "Type : Horse",
//                         size: 16,fontWeight: FontWeight.w100,
//                       ),
//                     if(model!.animaltypeId==5)
//                       text(
//                         text1: "Type : Donkey",
//                         size: 16,fontWeight: FontWeight.w100,
//                       ),
//                     SizedBox(height: 5,),
//                     text(
//                       text1: " Age : ${model.age}",
//                       size: 16,fontWeight: FontWeight.w100,
//                     ),
//
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/cubits_animals/cubit.dart';
import 'package:sara_front/cubits/cubits_animals/states.dart';
import 'package:sara_front/cubits/register/cubit.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/register/signin.dart';
import 'package:sara_front/screen/Settings.dart';
import 'package:sara_front/screen/add_animals.dart';
import 'package:sara_front/screen/animal_details.dart';
import 'package:sara_front/screen/edit_profile.dart';
import '../components/colors.dart';
import '../components/text.dart';
import '../components/textButton.dart';
import '../network/end_point.dart';

class Show_Animals extends StatefulWidget {
  @override
  State<Show_Animals> createState() => _Show_AnimalsState();
}

class _Show_AnimalsState extends State<Show_Animals>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  GlobalKey<ScaffoldState> scaffoldekey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
    AnimalCubit.get(context).getAllAnimal();
    AnimalCubit.get(context).getanimal_Type(1);
    AnimalCubit.get(context).getanimal_Type(2);
    AnimalCubit.get(context).getanimal_Type(3);
    AnimalCubit.get(context).getanimal_Type(4);
  }

  // Future<void> fetchAllAnimals(int tabIndex) async {
  //   // AnimalCubit.get(context).getAllAnimal();
  //   // AnimalCubit.get(context).getanimal_Type(1);
  //   return print('done');
  //
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size;
    return BlocConsumer<AnimalCubit, AnimalStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //state is GetAnimalSuccessState||state is GetCatsSuccessState
          if (AnimalCubit.get(context).allanimals != null &&
              AnimalCubit.get(context).get_animal_type != null) {
            print(AnimalCubit.get(context).allanimals?.data.length);
            return DefaultTabController(
                length: 5,
                child: Scaffold(
                  key: scaffoldekey,
                  backgroundColor: ColorApp.color,
                  appBar: AppBar(
                    title: text(
                      text1: 'Animals'.tr(),
                      color: ColorApp.color2,
                      size: 25,
                    ),
                    backgroundColor: Colors.white,
                    // actions: [IconButton(onPressed: (){scaffoldekey.currentState!.openDrawer();}, icon: Icon(Icons.add))],
                    bottom: TabBar(
                        tabs: [
                          Tab(
                            child: Text("All".tr()),
                          ),
                          Tab(
                            child: Text("Cats".tr()),
                          ),
                          Tab(
                            child: Text("Dogs".tr()),
                          ),
                          Tab(
                            child: Text("Birds".tr()),
                          ),
                          Tab(
                            child: Text("Horses".tr()),
                          ),
                        ],
                        unselectedLabelColor: Colors.grey[500],
                        labelColor: ColorApp.color2,
                        controller: _tabController,
                        isScrollable: true,
                        onTap: (index) {
                          if (index == 0) {
                            AnimalCubit.get(context).getAllAnimal();
                          } else
                            AnimalCubit.get(context).getanimal_Type(index);
                        }),
                  ),
                  drawer: Drawer(
                    width: 250,
                    backgroundColor: ColorApp.colorback,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 20, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorApp.color3,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 10),
                                    child: Text(
                                      "${CachHelper.getData(key: "name")}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: ColorApp.color2,
                              height: 20,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            textButton(
                                text: 'Profile'.tr(),
                                font: 'text normal',
                                size: 18,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Edit_Profile()));
                                }),
                            SizedBox(
                              height: 18,
                            ),
                            textButton(
                                text: 'Settings'.tr(),
                                font: 'text normal',
                                size: 18,
                                onTap: () {  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SettingsPage()));}),
                            SizedBox(
                              height: 18,
                            ),
                            textButton(
                                text: 'Adoption'.tr(),
                                font: 'text normal',
                                size: 18,
                                onTap: () {}),
                            SizedBox(
                              height: 18,
                            ),
                            textButton(
                                text: 'Sponserships'.tr(),
                                font: 'text normal',
                                size: 18,
                                onTap: () {}),
                            SizedBox(
                              height: 18,
                            ),
                            textButton(
                                text: 'Donate'.tr(),
                                font: 'text normal',
                                size: 18,
                                onTap: () {}),
                            SizedBox(
                              height: 18,
                            ),
                            textButton(
                                text: 'join us'.tr(),
                                font: 'text normal',
                                size: 18,
                                onTap: () {}),
                            SizedBox(
                              height: 18,
                            ),
                            textButton(
                                text: 'Log out'.tr(),
                                font: 'text normal',
                                size: 18,
                                onTap: () {
                                  openlogoutDialog(context);
                                }),
                            /*defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "profile",
                              //icon: Icons.edit,
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // defaultButton(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => Edit_Profile()));
                            //   },
                            //   r: 30,
                            //   h: 40,
                            //   w: screenWidth.width,
                            //   text: "Edit profile",
                            //   color: ColorApp.color3,
                            //   icon: Icons.edit,
                            //   textColor: ColorApp.color1,
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Settings",
                              color: ColorApp.color3,
                              //icon: Icons.settings,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Adoption",
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Sponserships",
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Donate",
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Join to us",
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultButton(
                              onTap: () {
                                openlogoutDialog(context);
                              },
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Logout",
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                          */
                          ],
                        ),
                      ),
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: role_id == "2"
                        ? Icon(
                            Icons.add,
                            size: 30,
                          )
                        : Icon(
                            Icons.search_rounded,
                            size: 30,
                          ),
                    onPressed: () {
                      role_id == "2"
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddAnimal()))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddAnimal()));
                    },
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBarView(controller: _tabController, children: [
                      Column(
                        children: [
                          Expanded(
                              child: GridView.count(
                            shrinkWrap: true,
                            childAspectRatio: 0.7,
                            crossAxisCount: 2,
                            children: List.generate(
                              AnimalCubit.get(context).allanimals!.data.length,
                              (index) => builditem(
                                  AnimalCubit.get(context)
                                      .allanimals!
                                      .data[index],
                                  context,
                                  index),
                            ),
                          )),
                        ],
                      ),
                      Column(
                        children: [
                          Expanded(
                              child: GridView.count(
                            crossAxisCount: 1,
                            childAspectRatio: 1.5,
                            children: List.generate(
                              AnimalCubit.get(context)
                                  .get_animal_type!
                                  .data
                                  .length,
                              (index) => builditem(
                                  AnimalCubit.get(context)
                                      .get_animal_type!
                                      .data[index],
                                  context,
                                  index),
                            ),
                          )),
                        ],
                      ),
                      Column(
                        children: [
                          Expanded(
                              child: GridView.count(
                            crossAxisCount: 1,
                            childAspectRatio: 1.5,
                            children: List.generate(
                              AnimalCubit.get(context)
                                  .get_animal_type!
                                  .data
                                  .length,
                              (index) => builditem(
                                  AnimalCubit.get(context)
                                      .get_animal_type!
                                      .data[index],
                                  context,
                                  index),
                            ),
                          )),
                        ],
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 1,
                              childAspectRatio: 1.5,
                              children: List.generate(
                                AnimalCubit.get(context)
                                    .get_animal_type!
                                    .data
                                    .length,
                                (index) => builditem(
                                    AnimalCubit.get(context)
                                        .get_animal_type!
                                        .data[index],
                                    context,
                                    index),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 1,
                              childAspectRatio: 1.5,
                              children: List.generate(
                                AnimalCubit.get(context)
                                    .get_animal_type!
                                    .data
                                    .length,
                                (index) => builditem(
                                    AnimalCubit.get(context)
                                        .get_animal_type!
                                        .data[index],
                                    context,
                                    index),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ));
          } else
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: ColorApp.color2,
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        child: Text("All".tr()),
                      ),
                      Tab(
                        child: Text("Cat".tr()),
                      ),
                      Tab(
                        child: Text("Dog".tr()),
                      ),
                      Tab(
                        child: Text("Birds".tr()),
                      ),
                      Tab(
                        child: Text("Horses".tr()),
                      ),
                    ],
                    labelColor: Colors.yellow,
                    controller: _tabController,
                  ),
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                  // : text(text1: "loading.....",size: 30,),
                ));
        });
  }

  ////////////////////

  Widget builditem(dynamic model, context, index) {
    return Container(
      height: 400,
      width: 520,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        // shadowColor:Colors.black,
        surfaceTintColor: ColorApp.color2,

        borderOnForeground: false,

        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              print(model.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AnimalDetails(id: model.id)),

                //id:model.id,
              );
              AnimalCubit.get(context).getanimal_Byid(model.id);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: ColorApp.colorback,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: 400,
                        minHeight: 180,
                      ),
                      child: model.photo != null
                          ? Image(
                              height: 180,
                              width: 400,
                              fit: BoxFit.fill,
                              image: MemoryImage(base64Decode(model.photo)),
                            )
                          : Container(),
                      decoration: BoxDecoration(
                        color: ColorApp.color3,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(
                          text1: "Name : ${model!.name}",
                          size: 20,
                          fontWeight: FontWeight.w200,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        if (model!.animaltypeId == 1)
                          text(
                            text1: "Type : Cat",
                            size: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        if (model!.animaltypeId == 2)
                          text(
                            text1: "Type : Dog",
                            size: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        if (model!.animaltypeId == 3)
                          text(
                            text1: "Type : Bird",
                            size: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        if (model!.animaltypeId == 4)
                          text(
                            text1: "Type : Horse",
                            size: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        if (model!.animaltypeId == 5)
                          text(
                            text1: "Type : Donkey",
                            size: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        // SizedBox(height: 5,),
                        text(
                          text1: " Age : ${model.age}",
                          size: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
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

  ///////////////////////////////////
  openlogoutDialog(BuildContext context) {
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
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 5, right: 5),
                //   child: Icon(
                //     Icons.logou,
                //     color: ColorApp.color2,
                //     size: 18,
                //   ),
                // ),
                Center(child: text(text1: 'Confirmation'.tr())),
              ],
            ),
            content: Text('Are you sure you want to logout?'.tr()),
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
                  text: 'Log out'.tr(),
                  color: ColorApp.color2,
                  onTap: () {
                    registerCubit.get(context).Log_out();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => signin()),
                    );
                  })
            ],
          ),
        );
      },
    );
  }
}
