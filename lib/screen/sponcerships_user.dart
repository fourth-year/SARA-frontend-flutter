import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/colors.dart';
import '../components/text.dart';
import '../cubits/User/cubit.dart';
import '../cubits/User/state.dart';

class sponcership_user extends StatefulWidget {


  @override
  State<sponcership_user> createState() => _sponcership_userState();
}

class _sponcership_userState extends State<sponcership_user> {

  void initState() {
    super.initState();
    UserCubit.get(context).sponcershipsuser();

  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserSates>(
      listener: ( context, state) {  },
      builder: (context, state) {

        return Scaffold(
            appBar: AppBar(title: text(
              themestyle: Theme.of(context).textTheme.headline5,
              text1:"Your Sponcerships".tr(),color: ColorApp.color2,
              size: 22,),
              leading: IconButton(onPressed: () {
                Navigator.pop(
                    context);
              }, icon: Icon(Icons.arrow_back_ios),),),
            body:
            (    UserCubit.get(context)
                .sponcershipmodel!=null)?
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
                              .sponcershipmodel!
                              .data
                              .length,
                              (index) => builditem(
                              UserCubit.get(context)
                                  .sponcershipmodel!
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
      padding: const EdgeInsets.all(3.0),
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
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorApp.colorback,
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
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
                            ? Image(
                          height: 100,
                          width: 120,
                          fit: BoxFit.fill,
                          image: MemoryImage(base64Decode(model!.animal!.photo)),
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                            text1: "Name animal:${model!.animal.name}".tr(),
                            size: 18,
                            fontWeight: FontWeight.w200,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          text(
                            text1: " the Type : ${model.animal.type}".tr(),
                            size: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          text(
                            text1: " the Date : ${model.updatedAt.year}-${model.updatedAt.month}-${model.updatedAt.day}".tr(),
                            size: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
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
