import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/screen/accept_emergenies.dart';
import 'package:sara_front/screen/add_animals.dart';
import 'package:sara_front/screen/feeding.dart';
import 'package:sara_front/screen/session.dart';
import 'package:sara_front/screen/vaccination.dart';

import '../components/colors.dart';
import '../components/text.dart';
import '../cubits/cubits_animals/cubit.dart';
import 'drawer.dart';

class Jops extends StatelessWidget {
  // GlobalKey<ScaffoldState> scaffoldekey= new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title:text(text1:"Tasks",color: ColorApp.color2,
        themestyle: Theme.of(context).textTheme.headline5,

        size: 22,),
        ),
      drawer: Drawer_Screen(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    surfaceTintColor: ColorApp.color2,
                    borderOnForeground: false,
                    child: defaultButton(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Feeding()));
                      },
                      text: "Feedings",

                      w: screenWidth.width,
                      h: 50,
                      s: 20,
                      color:
                      Theme.of(context).brightness == Brightness.light
                          ? ColorApp.color3// لون المظهر الخفيف
                          : Colors.grey[600] ?? ColorApp.color3,

                      textColor:  Theme.of(context).brightness == Brightness.light
                          ?  ColorApp.color1 // لون المظهر الخفيف
                          : Colors.white,
                    )),
                SizedBox(
                  height: 8,
                ),
                Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    surfaceTintColor: ColorApp.color2,
                    borderOnForeground: false,
                    child: defaultButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => vaccination()));
                      },
                      text: "vaccinations",
                      w: screenWidth.width,
                      h: 50,
                      s: 20,
                      color:
                      Theme.of(context).brightness == Brightness.light
                          ? ColorApp.color3// لون المظهر الخفيف
                          : Colors.grey[600] ?? ColorApp.color3,

                      textColor:  Theme.of(context).brightness == Brightness.light
                          ?  ColorApp.color1 // لون المظهر الخفيف
                          : Colors.white,
                    )),
                SizedBox(
                  height: 8,
                ),
                Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    surfaceTintColor: ColorApp.color2,
                    borderOnForeground: false,
                    child: defaultButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AcceptEmergenies()));
                      },
                      text: "Accept Emergencies",
                      w: screenWidth.width,
                      h: 50,
                      s: 20,
                      color:
                      Theme.of(context).brightness == Brightness.light
                          ? ColorApp.color3// لون المظهر الخفيف
                          : Colors.grey[600] ?? ColorApp.color3,

                      textColor:  Theme.of(context).brightness == Brightness.light
                          ?  ColorApp.color1 // لون المظهر الخفيف
                          : Colors.white,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
