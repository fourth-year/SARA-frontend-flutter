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

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/cubits/cubits_animals/cubit.dart';
import 'package:sara_front/cubits/cubits_animals/states.dart';
import 'package:sara_front/screen/animal_details.dart';
import '../components/colors.dart';
import '../components/text.dart';

class Show_Animals extends StatefulWidget {
  @override
  State<Show_Animals> createState() => _Show_AnimalsState();
}

class _Show_AnimalsState extends State<Show_Animals>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
                  backgroundColor: ColorApp.color,
                  appBar: AppBar(
                    title: Center(
                      child: text(
                        text1: 'Animals',
                        color: ColorApp.color2,
                        size: 25,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    bottom: TabBar(
                        tabs: [
                          Tab(
                            child: Text("All"),
                          ),
                          Tab(
                            child: Text("Cats"),
                          ),
                          Tab(
                            child: Text("Dogs"),
                          ),
                          Tab(
                            child: Text("Birds"),
                          ),
                          Tab(
                            child: Text("Horses"),
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
                        child: Text("All"),
                      ),
                      Tab(
                        child: Text("Cat"),
                      ),
                      Tab(
                        child: Text("Dog"),
                      ),
                      Tab(
                        child: Text("Birds"),
                      ),
                      Tab(
                        child: Text("Horses"),
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
    return Card(
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
                                builder: (context) => AnimalDetails(id:model.id)),
                                
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
                        const EdgeInsets.only(top: 8.0, bottom: 8, left: 10),
                    child: Container(
                      width: 500,
                      height: 75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorApp.color2),
                    )

                    // CircleAvatar(radius: 50, backgroundColor: ColorApp.color2
                    //   // NetworkImage(model!.data[index]!.photo.toString()),
                    //
                    //   // MemoryImage(base64Decode(model!.data[index]!.photo)),
                    // ),
                    ),
                SizedBox(
                  width: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
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
    );
  }
}
