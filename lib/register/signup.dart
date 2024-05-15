import 'dart:convert';
import 'dart:io';
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => signin(),
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorApp.colorback,
          body: SingleChildScrollView(
            child: Form(
              key: formkay,
              child: Column(
                children: [
                  ClipPath(
                    clipper: containerclipper(),
                    child: Container(
                      height: 120,
                      width: 600,
                      constraints: BoxConstraints(),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images/p1.jpg',
                              ),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  text(
                    text1: 'Register',
                    size: 35,
                    font: "title",
                    fontWeight: FontWeight.w100,
                    color: ColorApp.color2,
                  ),
                  text(
                    text1: 'Create your new accout ',
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
                                  color: ColorApp.color3,
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
                      hint: 'Full Name',
                      controller: namecontroller,
                      color: ColorApp.color,
                      prefix: Icon(Icons.person),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your name ";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, bottom: 18.0),
                    child: textfromfilde(
                      hint: 'Your Email',
                      controller: emailcontroller,
                      color: ColorApp.color,
                      type: TextInputType.emailAddress,
                      prefix: Icon(Icons.email_rounded),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your email ";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, bottom: 8.0),
                    child: textfromfilde(
                      hint: 'Your Password',
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
                          return "please enter your password";
                        }
                        return null;
                      },
                    ),
                  ),
                  passError
                      ? Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              text(
                                text1:
                                    'this field must contain at least 8 characters',
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
                      left: 18.0,
                      right: 18.0,
                      bottom: 8.0,
                    ),
                    child: textfromfilde(
                      hint: 'Confirm  Password',
                      controller: password1controller,
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
                          return "please enter your password";
                        }
                        return null;
                      },
                    ),
                  ),
                  passError
                      ? Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              text(
                                text1:
                                    'this field must contain at least 8 characters',
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
                      left: 18.0,
                      right: 18.0,
                      bottom: 18.0,
                    ),
                    child: textfromfilde(
                      hint: 'Address',
                      controller: addresscontroller,
                      color: ColorApp.color,
                      prefix: Icon(Icons.location_on_sharp),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, bottom: 10.0),
                    child: textfromfilde(
                      hint: 'Your Phone ',
                      count: 10,
                      controller: phonecontroller,
                      type: TextInputType.phone,
                      color: ColorApp.color,
                      prefix: Icon(Icons.phone),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your phone";
                        }
                        return null;
                      },
                    ),
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
                                text: "female",
                                textColor: registerCubit.get(context).f_gender,
                                color: ColorApp.color4),
                            SizedBox(width: 10),
                            defaultButton(
                              onTap: () {
                                registerCubit.get(context).type_gender("male");
                                gender = "female";
                              },
                              text: "male",
                              textColor: registerCubit.get(context).m_gender,
                              color: ColorApp.color4,
                              w: 140,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  showError
                      ? Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              text(
                                text1: 'chose the gender',
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
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Center(
                      child: defaultButton(
                          onTap: () {
                            if (formkay.currentState!.validate()) {
                              if ((passwordcontroller.text.length > 7 &&
                                  password1controller.text.length > 7)) {
                                setState(() {
                                  passError = false;
                                });
                                if (gender != '') {
                                  setState(() {
                                    showError = false;
                                  });
                                  gender = registerCubit.get(context).gender;
                                  registerCubit.get(context).usersignup(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text,
                                      c_password: password1controller.text,
                                      address: addresscontroller.text,
                                      name: namecontroller.text,
                                      phone: phonecontroller.text,
                                      photo: image64.toString(),
                                      gender: gender.toString());
                                  print(registerCubit.get(context).gender);
                                } else
                                  setState(() {
                                    showError = true;
                                  });
                              } else
                                setState(() {
                                  passError = true;
                                });
                            }
                          },
                          text: "Create Account",
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
                        text1: "Already have an account?",
                        size: 14,
                      ),
                      textButton(
                          text: "Log in",
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
