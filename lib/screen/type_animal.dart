import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/colors.dart';
import '../components/text.dart';
import '../cubits/cubits_animals/cubit.dart';
import '../cubits/cubits_animals/states.dart';
import 'animal_details.dart';

class type_an extends StatelessWidget {
   type_an({required this.type,required this.id_type, super.key});
String type;
int id_type;


  @override
  Widget build(BuildContext context) {

    AnimalCubit.get(context).getanimal_Type(id_type);

    return BlocConsumer<AnimalCubit, AnimalStates>(
      listener: (context,state){},
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(
            title: text(
              text1: type.tr(),
              themestyle: Theme
                  .of(context)
                  .textTheme
                  .headline5,
              color: ColorApp.color2,
              size: 25,
            ),
          ),
        body:AnimalCubit
            .get(context)
            .get_animal_type != null?
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    children: List.generate(
                      AnimalCubit.get(context).get_animal_type!.data.length,
                          (index)  {
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
                                  print(AnimalCubit.get(context).get_animal_type!.data[index].id);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AnimalDetails(id:AnimalCubit.get(context).get_animal_type!.data[index].id)),

                                    //id:model.id,
                                  );
                                  AnimalCubit.get(context).getanimal_Byid(AnimalCubit.get(context).get_animal_type!.data[index].id);
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
                                            minWidth: 300,
                                            minHeight: 100,
                                          ),
                                          child: AnimalCubit.get(context).get_animal_type!.data[index].photo != null
                                              ? Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  image:
                                                  MemoryImage(base64Decode(AnimalCubit.get(context).get_animal_type!.data[index]!.photo!)),
                                                  fit: BoxFit.fill,
                                                )),
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
                                                  text1: "${AnimalCubit.get(context).get_animal_type!.data[index].name}",
                                                  size: 18,
                                                  fontWeight: FontWeight.w200,
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
                          );




                          }

                    ),
                  ),
                ),
              ],
            ),
          ),
        )

        :Center(child: CircularProgressIndicator(),)



        );


      },
    );
  }
}
