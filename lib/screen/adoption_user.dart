import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/colors.dart';
import '../components/text.dart';
import '../cubits/User/cubit.dart';
import '../cubits/User/state.dart';

class adoption_user extends StatefulWidget {


  @override
  State<adoption_user> createState() => _adoption_userState();
}

class _adoption_userState extends State<adoption_user> {

  void initState() {
    super.initState();
    UserCubit.get(context).adoptionuser();

  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserSates>(
      listener: ( context, state) {  },
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(title: text(text1:"Your adoptions".tr(),color: ColorApp.color2,
            themestyle: Theme.of(context).textTheme.headline5,

            size: 22,),
            leading: IconButton(onPressed: () {
              Navigator.pop(
                  context);
            }, icon: Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: Icon(Icons.arrow_back_ios),
            ),),),
          body:
          (    UserCubit.get(context)
              .adoptionmodel!=null)?
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:

              Column(
                children: [
                  Expanded(
                      child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: 2.5,
                        children: List.generate(
                          UserCubit.get(context)
                              .adoptionmodel!
                              .data
                              .length,
                              (index) => builditem(
                                  UserCubit.get(context)
                                  .adoptionmodel!
                                  .data[index],
                              context,
                              index),
                        ),
                      )),
                ],
              ),


          )
        :Center(child: CircularProgressIndicator())

        );
      },);
  }

  Widget builditem(dynamic model, context, index) {
    return Padding(
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
                        child: model.animal!.photo != null
                            ?
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: MemoryImage(base64Decode(model!.animal!.photo)),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,                        children: [
                        text(
                          text1: "Name animal :".tr()+" ${model!.animal.name}".tr(),
                          size: 18,
                          fontWeight: FontWeight.w200,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        text(
                          text1: " the Type :".tr()+"${model.animal.type}".tr(),
                          size: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        text(
                          text1: "the Date :".tr()+" ${model.updatedAt.year}-${model.updatedAt.month}-${model.updatedAt.day}".tr(),
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
}
