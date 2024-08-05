import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sara_front/cubits/cubits_animals/cubit.dart';
import 'package:sara_front/network/end_point.dart';

import '../components/colors.dart';
import '../components/text.dart';

class Layout extends StatefulWidget {


  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  // final _layoutScaffoldKey  = GlobalKey<ScaffoldState>();
  // GlobalKey<FormState> _layoutScaffoldKey  = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _layoutScaffoldKey ,

      bottomNavigationBar:CurvedNavigationBar(
          height: 65,
          index:  AnimalCubit.get(context).curentindex,
          backgroundColor: Colors.white,
          buttonBackgroundColor: ColorApp.color2,
          color: ColorApp.color2,
          onTap: (index){
            setState(() {
              AnimalCubit.get(context).changBottom(index);
            });

          },

          items:role_id == "2"||role_id == "4"?
          <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.grid_view_rounded,size :26,color: Colors.white,),
                  AnimalCubit.get(context).curentindex==0?SizedBox():
                  text(text1: 'animals',color: Colors.white ,size: 14,fontWeight: FontWeight.w100,)

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home_filled,size :26,color: Colors.white,),
                  // Text('home', style: TextStyle(color: Colors.white)),
                  AnimalCubit.get(context).curentindex==1?SizedBox():
                  text(text1: 'home',color: Colors.white ,size: 14,fontWeight: FontWeight.w100,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.medical_services,size :26,color: Colors.white,),
                  AnimalCubit.get(context).curentindex==2?SizedBox():
                  text(text1: 'emegance',color: Colors.white ,size: 14,fontWeight: FontWeight.w100,)

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt_sharp,size :26,color: Colors.white,),
                  AnimalCubit.get(context).curentindex==3?SizedBox():
                  text(text1: 'task',color: Colors.white ,size: 14,fontWeight: FontWeight.w100,)

                ],
              ),
            ),
          ]
              :
          <Widget>[
            Icon(Icons.grid_view_rounded,size :26,color: Colors.white,),
            Icon(Icons.home_filled,size :26,color: Colors.white,),
            Icon(Icons.medical_services,size :26,color: Colors.white,),
            Icon(Icons.more_horiz,size :26,color: Colors.white,),
            // Icon(Icons.grid_view_rounded,size :26,color: Colors.white,)
          ]
      ),
      // BottomNavigationBar(
      //     selectedLabelStyle: TextStyle(fontSize: 14),
      //     unselectedLabelStyle: TextStyle(fontSize: 13),
      //     elevation: 5.5,
      //     type: BottomNavigationBarType.fixed,
      //     currentIndex: AnimalCubit.get(context).curentindex,
      //     onTap: (index) {
      //       setState(() {
      //         AnimalCubit.get(context).changBottom(index);
      //       });
      //     },
      //     items: role_id == "2"||role_id == "4"
      //         ? [
      //             BottomNavigationBarItem(
      //                 icon: Icon(
      //                   Icons.grid_view_rounded,
      //                 ),
      //                 label: 'Animals'.tr()),
      //             BottomNavigationBarItem(
      //                 icon: Icon(
      //                   Icons.home_filled,
      //                 ),
      //                 label: 'Home'.tr()),
      //             BottomNavigationBarItem(
      //                 icon: Icon(
      //                   Icons.medical_services,
      //                 ),
      //                 label: 'Emergencies'.tr()),
      //             BottomNavigationBarItem(
      //                 icon: Icon(
      //                   Icons.home_filled,
      //                 ),
      //                 label: 'Jobs'.tr()),
      //           ]
      //         : [
      //             BottomNavigationBarItem(
      //                 icon: Icon(
      //                   Icons.grid_view_rounded,
      //                 ),
      //                 label: 'Animals'),
      //             BottomNavigationBarItem(
      //                 icon: Icon(
      //                   Icons.home_filled,
      //                 ),
      //                 label: 'Home'),
      //             BottomNavigationBarItem(
      //                 icon: Icon(
      //                   Icons.medical_services,
      //                 ),
      //                 label: 'emergencies'),
      //
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.more_horiz,
      //           ),
      //           label: 'More'),
      //
      //           ]),
      body:

      role_id == "2"||role_id == "4"?
          AnimalCubit.get(context).screen[AnimalCubit.get(context).curentindex]:
          AnimalCubit.get(context).screen_user[AnimalCubit.get(context).curentindex]
    );
  }
}
