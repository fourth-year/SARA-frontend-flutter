import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/screen/feeding.dart';
import 'package:sara_front/screen/session.dart';
import 'package:sara_front/screen/vaccination.dart';
import '../components/colors.dart';
import '../components/text.dart';
import 'donation.dart';
import 'drawer.dart';

class more extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: text(
          text1: 'S.A.R.A',
          color: ColorApp.color2,
          themestyle: Theme.of(context).textTheme.headline5,
          size: 24,
        ),
      ),
      drawer: Drawer_Screen(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
              top: 35,
            ),
            child: text(
              text1: '',
              color: ColorApp.color2,
              size: 35,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 50),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        surfaceTintColor: ColorApp.color2,
                        borderOnForeground: false,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => session()),

                              //id:model.id,
                            );
                          },
                          child: Container(
                              width: screenWidth.width / 3,
                              height: 200,
                              decoration: BoxDecoration(
                                color: ColorApp.colorback,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: screenWidth.width / 3,
                                    height: 170,
                                    decoration: BoxDecoration(
                                      color: ColorApp.colorback,
                                      borderRadius: BorderRadius.circular(24),
                                      image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/session.jpg',
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                    child: SizedBox(),
                                  ),
                                  text(
                                      text1: 'Session'.tr(),
                                      size: 15,
                                      themestyle: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ],
                              )),
                        )),
                    SizedBox(
                      width: 25,
                    ),
                    Card(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        surfaceTintColor: ColorApp.color2,
                        borderOnForeground: false,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => donation()),

                              //id:model.id,
                            );
                          },
                          child: Container(
                              width: screenWidth.width / 3,
                              height: 200,
                              decoration: BoxDecoration(
                                color: ColorApp.colorback,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: screenWidth.width / 3,
                                    height: 170,
                                    decoration: BoxDecoration(
                                      color: ColorApp.colorback,
                                      borderRadius: BorderRadius.circular(24),
                                      image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/donate.png',
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                    child: SizedBox(),
                                  ),
                                  text(
                                      text1: 'Donate'.tr(),
                                      size: 15,
                                      themestyle: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ],
                              )),
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
