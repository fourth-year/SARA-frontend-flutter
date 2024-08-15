import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/cubits/cubits_animals/cubit.dart';
import 'package:sara_front/cubits/cubits_animals/states.dart';
import 'package:sara_front/cubits/register/cubit.dart';
import 'package:sara_front/register/signin.dart';
import 'package:sara_front/screen/add_animals.dart';
import 'package:sara_front/screen/animal_details.dart';
import '../components/colors.dart';
import '../components/text.dart';
import '../components/textButton.dart';
import '../network/end_point.dart';
import 'donation.dart';
import 'drawer.dart';

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
    // AnimalCubit.get(context).All_Type_Model();

    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
    AnimalCubit.get(context).getAllAnimal();
    AnimalCubit.get(context).getanimal_Type(1);
    // AnimalCubit.get(context).getanimal_Type(2);
    // AnimalCubit.get(context).getanimal_Type(3);
    // AnimalCubit.get(context).getanimal_Type(4);
    AnimalCubit.get(context).All_Type_Model();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size;
    return BlocConsumer<AnimalCubit, AnimalStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //state is GetAnimalSuccessState||state is GetCatsSuccessState
         if (AnimalCubit
             .get(context)
             .Type_Model != null) {
            if (AnimalCubit
                .get(context)
                .allanimals != null &&
                AnimalCubit
                    .get(context)
                    .get_animal_type != null) {
              print(AnimalCubit
                  .get(context)
                  .allanimals
                  ?.data
                  .length);
              return DefaultTabController(
                  length: 5,
                  child: Scaffold(
                    key: scaffoldekey,
                    appBar: AppBar(
                      title: text(
                        text1: 'Animals'.tr(),
                        themestyle: Theme
                            .of(context)
                            .textTheme
                            .headline5,
                        color: ColorApp.color2,
                        size: 25,
                      ),
                      bottom: TabBar(
                          tabs: [
                            Tab(
                              child: Text("All".tr()),
                            ),
                            // for (String typeName in AnimalCubit
                            //     .get(context)
                            //     .typeNames ?? [])
                            //   Tab(
                            //     child: Text(typeName),
                            //   ),


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

                          controller: _tabController,
                          isScrollable: true,
                          onTap: (index) {
                            if (index == 0) {
                              AnimalCubit.get(context).getAllAnimal();
                            } else
                              AnimalCubit.get(context).getanimal_Type(index);
                          }),
                    ),
                    drawer: Drawer_Screen(),
                    drawerEdgeDragWidth: 0,

                    floatingActionButton: FloatingActionButton(
                      backgroundColor: ColorApp.color2,


                      child: role_id == "2" || role_id == "4"
                          ? Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,)
                          : Icon(
                          Icons.search_rounded,
                          size: 30,
                          color: Colors.white),
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
                                  childAspectRatio: 0.8,
                                  crossAxisCount: 2,
                                  children: List.generate(
                                    AnimalCubit
                                        .get(context)
                                        .allanimals!
                                        .data
                                        .length,
                                        (index) =>
                                        builditem(
                                            AnimalCubit
                                                .get(context)
                                                .allanimals!
                                                .data[index],
                                            context,
                                            index),
                                  ),
                                )),
                          ],
                        ),
                        // for (int i=1;i <= AnimalCubit
                        //     .get(context)
                        //     .typeNames!.length ;i++)
                        //   Column(
                        //     children: [
                        //       Expanded(
                        //           child: GridView.count(
                        //             crossAxisCount: 1,
                        //             childAspectRatio: 1.5,
                        //             children: List.generate(
                        //               AnimalCubit
                        //                   .get(context)
                        //                   .get_animal_type!
                        //                   .data
                        //                   .length,
                        //                   (index) =>
                        //                   builditem(
                        //                       AnimalCubit
                        //                           .get(context)
                        //                           .get_animal_type!
                        //                           .data[index],
                        //                       context,
                        //                       index),
                        //             ),
                        //           )),
                        //     ],
                        //   ),
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
            }
            else
              return Scaffold(
                  appBar: AppBar(
                    title: text(
                      text1: 'Animals'.tr(),
                      themestyle: Theme.of(context).textTheme.headline5,
                      color: ColorApp.color2,
                      size: 25,
                    ),
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
                        controller: _tabController,
                        isScrollable: true,
                        onTap: (index) {
                          if (index == 0) {
                            AnimalCubit.get(context).getAllAnimal();
                          } else
                            AnimalCubit.get(context).getanimal_Type(index);
                        }),
                  ),
                  drawer: Drawer_Screen(),
                  drawerEdgeDragWidth: 0,

                  body: Center(
                    child: CircularProgressIndicator(),
                    // : text(text1: "loading.....",size: 30,),
                  ));
          }

          else
            return Scaffold(
                appBar: AppBar(
                  title: text(
                    text1: 'Animals'.tr(),
                    themestyle: Theme.of(context).textTheme.headline5,
                    color: ColorApp.color2,
                    size: 25,
                  ),
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
                      controller: _tabController,
                      isScrollable: true,
                      onTap: (index) {
                        if (index == 0) {
                          AnimalCubit.get(context).getAllAnimal();
                        } else
                          AnimalCubit.get(context).getanimal_Type(index);
                      }),
                ),
                drawer: Drawer_Screen(),
                drawerEdgeDragWidth: 0,

                body: Center(
                  child: CircularProgressIndicator(),
                  // : text(text1: "loading.....",size: 30,),
                ));
        });
  }

  ////////////////////

  Widget builditem(dynamic model, context, index) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      // shadowColor:Colors.black,
      surfaceTintColor: ColorApp.color2,

      borderOnForeground: false,

      child: Padding(
        padding: const EdgeInsets.all(2.0),
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
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(18)),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 400,
                      minHeight: 120,
                    ),
                    child: model.photo != null
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image:
                                      MemoryImage(base64Decode(model.photo)),
                                  fit: BoxFit.fill,
                                )),
                            // child: Image(
                            //     height: 120,
                            //     width: 400,
                            //     fit: BoxFit.fill,
                            //     image: MemoryImage(base64Decode(model.photo)),
                            //   ),
                          )
                        : Container(),
                    decoration: BoxDecoration(
                      color: ColorApp.color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 10,left: 10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          text(themestyle: Theme.of(context).textTheme.headline6,
                            text1: "${model!.name}",
                            size: 18,
                            fontWeight: FontWeight.w200,
                          ),
                          // SizedBox(
                          //   height: 3.0,
                          // ),
                          if (model!.animaltypeId == 1)
                            text(
                              text1: " Cat".tr(),
                              size: 14,
                              fontWeight: FontWeight.normal,
                              themestyle: Theme.of(context).textTheme.subtitle1,
                            ),
                          if (model!.animaltypeId == 2)
                            text( themestyle: Theme.of(context).textTheme.subtitle1,
                              text1: " Dog".tr(),
                              size: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          if (model!.animaltypeId == 3)
                            text(themestyle: Theme.of(context).textTheme.subtitle1,
                              text1: " Bird".tr(),
                              size: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          if (model!.animaltypeId == 4)
                            text(themestyle: Theme.of(context).textTheme.subtitle1,
                              text1: " Horse".tr(),
                              size: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          if (model!.animaltypeId == 5)
                            text(themestyle: Theme.of(context).textTheme.subtitle1,
                              text1: "Type : Donkey".tr(),
                              size: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          // SizedBox(height: 5,),
                          // text(
                          //   text1: " Age : ${model.age}",
                          //   size: 14,
                          //   fontWeight: FontWeight.normal,
                          // ),
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
