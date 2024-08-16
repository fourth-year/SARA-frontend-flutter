import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/register/cubit.dart';
import 'package:sara_front/cubits/register/states.dart';
import '../components/textButton.dart';
import '../network/cach_helper.dart';
import '../network/end_point.dart';
import '../screen/layout.dart';
import 'signin.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController password1controller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  var formkay = GlobalKey<FormState>();
  bool showError = false;
  bool passError = false;

  late String gender = '';
  final _picker = ImagePicker();
  File? _image;
  late String image64 = '';

  @override
  Widget build(BuildContext context) {
    Future<void> _openImagePicker() async {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
          var bytes = _image?.readAsBytesSync();
          if (bytes != null) {
            image64 = base64.encode(bytes);
            print(image64);
          }
        });
      }
    }

    return BlocConsumer<registerCubit, registerSates>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          CachHelper.savetoken(key: 'token', value: state.signupModel.accessToken.toString()).then((value) {
            token=CachHelper.gettoken(key: "token");
            print ('save token');
            CachHelper.saveData(key: "role_id", value: 1.toString());
            role_id=CachHelper.getData(key: "role_id");



              CachHelper.savetoken(key: 'name', value: state.signupModel.user.name.toString());
              CachHelper.savetoken(key: 'address', value: state.signupModel.user.address.toString());
              CachHelper.savetoken(key: 'phone', value: state.signupModel.user.phone.toString());
              CachHelper.savetoken(key: 'email', value: state.signupModel.user.email.toString());
              CachHelper.savetoken(key: 'photo', value: state.signupModel.user.photo.toString());
              CachHelper.savetoken(key: 'id', value: state.signupModel.user.id.toString());

              CachHelper.savetoken(key: 'gender', value: state.signupModel.user.gender.toString());


              Navigator.push(context,MaterialPageRoute(builder: (context) => Layout(),));

          }
          );
        }

        if (state is SignupErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Please ensure of the entered information'.tr(),
              style: TextStyle(
                color: ColorApp.color2,
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
            closeIconColor: ColorApp.color2,
            backgroundColor: ColorApp.colorback,
          ));
        }

      },
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(),
          backgroundColor: ColorApp.colorback,
          body: SingleChildScrollView(
            child: Form(
              key: formkay,
              child: Column(
                children: [
                  // ClipPath(
                  //   clipper: containerclipper(),
                  //   child: Container(
                  //     height: 120,
                  //     width: 600,
                  //     constraints: BoxConstraints(),
                  //     decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //             image: AssetImage(
                  //               'assets/images/p1.jpg',
                  //             ),
                  //             fit: BoxFit.cover)),
                  //   ),
                  // ),
                  SizedBox(height: 80,),
                  text(
                    text1: 'Register'.tr(),
                    themestyle: Theme.of(context).textTheme.headline3,

                    size: 35,
                    font: "title",
                    fontWeight: FontWeight.w100,
                    color: ColorApp.color2,
                  ),
                  text(
                    text1: 'Create your new accout'.tr(),
                    themestyle: Theme.of(context).textTheme.headline4,

                    size: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        _openImagePicker();
                      },
                      child: _image == null
                          ? Stack(children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorApp.color,
                                ),
                              ),
                              Positioned(
                                top: 110,
                                left: 55,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 35,
                                  color: ColorApp.color2,
                                ),
                              ),
                            ])
                          : Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorApp.color3,
                              ),
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: FileImage(File(_image!.path)),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, bottom: 18.0),
                    child: textfromfilde(
                      hint: 'Full Name'.tr(),
                      controller: namecontroller,
                      color: ColorApp.color,
                      prefix: Icon(Icons.person),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your name".tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, bottom: 18.0),
                    child: textfromfilde(
                      hint: 'Your Email'.tr(),
                      controller: emailcontroller,
                      color: ColorApp.color,
                      type: TextInputType.emailAddress,
                      prefix: Icon(Icons.email_rounded),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your email".tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, bottom: 18.0),
                    child: textfromfilde(
                      hint: 'Your Password'.tr(),
                      controller: passwordcontroller,
                      color: ColorApp.color,
                      prefix: Icon(Icons.lock_rounded),
                      type: TextInputType.visiblePassword,
                      obscure: registerCubit.get(context).ispassword,
                      suffixPressed: () {
                        registerCubit.get(context).changpassword();
                      },
                      suffix: registerCubit.get(context).suffix,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password".tr();
                        }

                        else {
                          if (passwordcontroller.text.length < 8) {
                            return "this field must contain at least 8 characters".tr();
                          }}

                          return null;
                        },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      right: 18.0,
                      bottom: 18.0,
                    ),
                    child: textfromfilde(
                      hint: 'Confirm Password'.tr(),
                      controller: password1controller,
                      color: ColorApp.color,
                      prefix: Icon(Icons.lock_rounded),
                      type: TextInputType.visiblePassword,
                      obscure: registerCubit.get(context).ispassword_c,
                      suffixPressed: () {
                        registerCubit.get(context).changpassword_c();
                      },
                      suffix: registerCubit.get(context).suffix_c,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password".tr();
                        }

                        else {
                          if (password1controller.text.length < 8) {
                            return "this field must contain at least 8 characters".tr();
                          }}
                        },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      right: 18.0,
                      bottom: 18.0,
                    ),
                    child: textfromfilde(
                      hint: 'Address'.tr(),
                      controller: addresscontroller,
                      color: ColorApp.color,
                      prefix: Icon(Icons.location_on_sharp),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, bottom: 10.0),
                    child: textfromfilde(
                      hint: 'Your Phone'.tr(),
                      count: 10,
                      controller: phonecontroller,
                      type: TextInputType.phone,
                      color: ColorApp.color,
                      prefix: Icon(Icons.phone),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your phone".tr();
                        }
                        return null;
                      },
                    ),
                  ),

                  showError
                      ? Padding(
                    padding: const EdgeInsets.only(left: 40.0,right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        text(
                          text1: 'chose the gender'.tr(),
                          color: ColorApp.color2,
                          size: 12,
                          fontWeight: FontWeight.w100,
                        ),
                      ],
                    ),
                  )
                      : SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, bottom: 0),
                    child: Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: ColorApp.color,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultButton(
                                onTap: () {
                                  gender = "female";
                                  registerCubit
                                      .get(context)
                                      .type_gender("female");
                                },
                                w: 140,
                                text: "female".tr(),
                                textColor: registerCubit.get(context).f_gender,
                                color: ColorApp.color4),
                            SizedBox(width: 10),
                            defaultButton(
                              onTap: () {
                                registerCubit.get(context).type_gender("male");
                                gender = "female";
                              },
                              text: "male".tr(),
                              textColor: registerCubit.get(context).m_gender,
                              color: ColorApp.color4,
                              w: 140,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                   SizedBox(
              height: 10,
            ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: defaultButton(
                          onTap: () {
                            if (formkay.currentState!.validate()) {

                              setState(() {
                                passError = false;
                              });
                              if (gender != '') {
                                setState(() {
                                  showError = false;
                                });
                                gender = registerCubit.get(context).gender;
                                registerCubit.get(context).SignUp(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text,
                                    c_password: password1controller.text,
                                    address: addresscontroller.text,
                                    name: namecontroller.text,
                                    phone: phonecontroller.text,
                                    photo: image64.toString(),
                                    gender:gender.toString());
                                print(registerCubit.get(context).gender);
                              } else
                                setState(() {
                                  showError = true;
                                });

                            }
                          },
                          text: "Create Account".tr(),
                          w: 150,
                          h: 45,
                          r: 10,
                          s: 15,
                          color: ColorApp.color2
                        // Color.fromRGBO(255, 239, 193,1),
                      ),
                    ),
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text(
                        text1: "Already have an account?".tr(),
                        size: 14,
                      ),
                      textButton(
                          text: "Log in".tr(),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => signin(),
                                ));
                          })
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class containerclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var h = size.height;
    var w = size.width;
    path.moveTo(0, 0);
    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.3, h * 0.98, w * 0.50, h * 0.8);
    path.quadraticBezierTo(w * 0.8, h * 0.7, w, h);
    path.lineTo(w, 0);
    path.close();
    //throw UnimplementedError();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
    // throw UnimplementedError();
  }
}
