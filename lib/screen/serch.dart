
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/cubits/cubits_animals/cubit.dart';
import 'package:sara_front/cubits/cubits_animals/states.dart';
import '../components/colors.dart';
import '../components/text.dart';
import '../components/textfromfilde.dart';
import 'animal_details.dart';

class Serch extends StatelessWidget {
  Serch({super.key});
  var searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AnimalCubit.get(context).searchResults=[];

    return BlocConsumer<AnimalCubit,AnimalStates>(
      listener: (BuildContext context, AnimalStates state) {  },
      builder: (BuildContext context, AnimalStates state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [



                TextFormField(

                  controller: searchcontroller,
                  onChanged: (value) {
                    // context.read<AnimalCubit>().serch_name(value);
                    searchcontroller.text.isNotEmpty?
                    AnimalCubit.get(context).serch_name(searchcontroller.text)
                    :    AnimalCubit.get(context).searchResults=[];

                  },
                  decoration: InputDecoration(



                    contentPadding:
                    EdgeInsets.only(left: 25, top: 18, bottom: 18, right: 30),
                    filled: true,
                    // fillColor: ColorApp.color,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),fillColor:  Theme.of(context).brightness == Brightness.light
                      ? Colors.grey[300] // لون المظهر الخفيف
                      : Colors.grey[800] ?? ColorApp.color3,


                    hintText: 'Search'.tr(),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(Icons.search_rounded),
                    ),
                  ),

                ),

SizedBox(height: 20,),
                AnimalCubit.get(context).searchResults.isNotEmpty?
               Expanded(
                 child: ListView.builder(
                     itemBuilder:(context,index)=>
                         GestureDetector(
                         onTap: () {
                           print(AnimalCubit.get(context).searchResults[index].id);
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => AnimalDetails(id: AnimalCubit.get(context).searchResults[index].id)),

                             //id:model.id,
                           );
                           AnimalCubit.get(context).getanimal_Byid(AnimalCubit.get(context).searchResults[index].id);
                         },
                           child: Padding(
                             padding: const EdgeInsets.all(2.0),
                             child: Container(
                               height: 100,
                               width: 520,
                               child: Card(
                                 elevation: 3.0,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(26.0),
                                 ),
                                 // shadowColor:Colors.black,
                                 surfaceTintColor: ColorApp.color2,

                                 borderOnForeground: false,

                                 child: Padding(
                                   padding: const EdgeInsets.all(3.0),
                                   child: Container(
                                     decoration: BoxDecoration(
                                       // color: ColorApp.colorback,
                                         borderRadius: BorderRadius.circular(20)),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Expanded(
                                           child: Padding(
                                             padding:
                                             const EdgeInsets.only(top: 8.0, left: 10, right: 10,bottom: 10),
                                             child: Container(
                                               constraints: BoxConstraints(
                                                 minWidth: 120,
                                                 minHeight: 60,
                                               ),
                                               child: AnimalCubit.get(context).searchResults[index].photo != null
                                                   ?
                                               Container(
                                                 decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.circular(20),
                                                     image: DecorationImage(
                                                       image: MemoryImage(base64Decode(AnimalCubit.get(context).searchResults[index].photo!)),
                                                       fit: BoxFit.fill,
                                                     )

                                                 ),
                                               )

                                                   : Container( height: 120,
                                                 width: 120,),
                                               decoration: BoxDecoration(
                                                 color: ColorApp.color3,
                                                 borderRadius: BorderRadius.circular(20),
                                               ),
                                             ),
                                           ),
                                         ),
                                         Expanded(
                                           flex: 2,
                                           child: Row(
                                             // mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 mainAxisAlignment: MainAxisAlignment.center,                                                 children: [
                                                   text(
                                                     text1: "Name animal :".tr()+" ${AnimalCubit.get(context).searchResults[index].name}",
                                                     size: 18,
                                                     fontWeight: FontWeight.w200,
                                                   ),
                                                   SizedBox(
                                                     height: 5.0,
                                                   ),
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
                             ),
                           ),
                         ),


                         // Container(width:500 ,child: Column(children: [Text(AnimalCubit.get(context).searchResults[index].name)],)),
                     itemCount: AnimalCubit.get(context).searchResults.length),
               )
                   :SizedBox()

              ],




            ),
          ),
          
          
          
          
          
          
          
          
          
          
          
          
          
        );  
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      },
      
      
      
    );
  }
}
