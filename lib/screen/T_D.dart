import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/screen/show_animals.dart';

import '../components/colors.dart';
import '../components/text.dart';
import '../cubits/cubits_animals/cubit.dart';
import '../cubits/cubits_animals/states.dart';

class T_D extends  StatefulWidget {
  const T_D({super.key});

  @override
  State<T_D> createState() => _T_DState();
}

class _T_DState extends State<T_D> {
  void initState() {
     super.initState();
    AnimalCubit.get(context).All_Type_Model();
  }






  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimalCubit, AnimalStates>(
        builder:(context, state)  {
          return
           Scaffold( appBar: AppBar(
          title: text(
          text1: 'Animals'.tr(),
          themestyle: Theme
              .of(context)
              .textTheme
              .headline5,
          color: ColorApp.color2,
          size: 25,
          ),),
             body:
          Center(
          child: CircularProgressIndicator(),
          // : text(text1: "loading.....",size: 30,),
          )
           );

        },
        listener:(context, state) {
          (AnimalCubit.get(context).typeNames!=null)?
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Show_Animals())
          ):null;


        });
  }
}
