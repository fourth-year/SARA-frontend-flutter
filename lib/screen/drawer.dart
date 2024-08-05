import 'package:flutter/cupertino.dart';
import 'package:sara_front/cubits/register/cubit.dart';
import 'package:sara_front/network/end_point.dart';
import 'package:sara_front/screen/adoption_user.dart';
import 'package:sara_front/screen/join_us_page.dart';
import 'package:sara_front/screen/sponcerships_user.dart';
import '../components/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/screen/Settings.dart';
import 'package:sara_front/screen/edit_profile.dart';
import 'package:sara_front/screen/wallet.dart';
import '../components/text.dart';
import '../components/textButton.dart';
import '../cubits/User/cubit.dart';
import '../register/signin.dart';
import 'donation.dart';

class Drawer_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: ColorApp.colorback,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 45, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorApp.color3,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        "${CachHelper.getData(key: "name")}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: ColorApp.color2,
                height: 20,
                thickness: 2,
              ),
              SizedBox(
                height: 15,
              ),
              textButton(
                  text: 'Profile'.tr(),
                  font: 'text normal',
                  size: 18,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit_Profile()));
                  }),
              SizedBox(
                height: 18,
              ),
              textButton(
                  text: 'Settings'.tr(),
                  font: 'text normal',
                  size: 18,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  }),
              SizedBox(
                height: 18,
              ),
              textButton(
                  text: 'Wallet'.tr(),
                  font: 'text normal',
                  size: 18,
                  onTap: () {
                    UserCubit.get(context).user_Wallet();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Wallet()));
                  }),
              SizedBox(
                height: 18,
              ),
              textButton(
                  text: 'Adoption'.tr(),
                  font: 'text normal',
                  size: 18,
                  onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => adoption_user(),
                        ));


                  }),
              SizedBox(
                height: 18,
              ),
              textButton(
                  text: 'Sponserships'.tr(),
                  font: 'text normal',
                  size: 18,
                  onTap: () {
                    UserCubit.get(context).sponcershipsuser();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => sponcership_user(),
                        ));

                  }),
              // SizedBox(
              //   height: 18,
              // ),
              // textButton(
              //     text: 'Donate'.tr(),
              //     font: 'text normal',
              //     size: 18,
              //     onTap: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => donation()));
              //     }),
              SizedBox(
                height: 18,
              ),
              (role_id == "1")
                  ?
                  Padding(
                    padding: const EdgeInsets.only(bottom:18.0),
                    child: textButton(
                    text: 'join us'.tr(),
                    font: 'text normal',
                    size: 18,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JoinUsPage(),
                          ));
                    }),
                  )
                  : SizedBox( ),

              textButton(
                  text: 'Log out'.tr(),
                  font: 'text normal',
                  size: 18,
                  onTap: () {
                    openlogoutDialog(context);
                  }),

              SizedBox(
                height: 18,
              ),
              /*defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "profile",
                              //icon: Icons.edit,
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // defaultButton(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => Edit_Profile()));
                            //   },
                            //   r: 30,
                            //   h: 40,
                            //   w: screenWidth.width,
                            //   text: "Edit profile",
                            //   color: ColorApp.color3,
                            //   icon: Icons.edit,
                            //   textColor: ColorApp.color1,
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Settings",
                              color: ColorApp.color3,
                              //icon: Icons.settings,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Adoption",
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Sponserships",
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Donate",
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultButton(
                              onTap: () {},
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Join to us",
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultButton(
                              onTap: () {
                                openlogoutDialog(context);
                              },
                              r: 30,
                              h: 40,
                              w: screenWidth.width,
                              text: "Logout",
                              color: ColorApp.color3,
                              textColor: ColorApp.color1,
                            ),
                          */
            ],
          ),
        ),
      ),
    );
  }

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
