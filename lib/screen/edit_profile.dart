import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/register/cubit.dart';
import 'package:sara_front/cubits/register/states.dart';
import 'package:sara_front/network/cach_helper.dart';
import '../components/textButton.dart';
import 'package:image_picker/image_picker.dart';

class Edit_Profile extends StatefulWidget {
  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  TextEditingController namecontroller = TextEditingController();

  TextEditingController emailcontroller = TextEditingController();

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
    namecontroller.text = CachHelper.getData(key: 'name');
    addresscontroller.text = CachHelper.getData(key: "address");
    phonecontroller.text = CachHelper.getData(key: "phone");
    emailcontroller.text = CachHelper.getData(key: "email");
    image64 = CachHelper.getData(key: "photo");
    gender = CachHelper.getData(key: "gender");
    registerCubit.get(context).type_gender(gender);

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
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          backgroundColor: ColorApp.colorback,
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: formkay,
              child: Column(
                children: [
                  text(
                    text1: 'Update Profile',
                    size: 35,
                    font: "title",
                    fontWeight: FontWeight.w100,
                    color: ColorApp.color2,
                  ),
                  text(
                    text1: '',
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Center(
                      child: defaultButton(
                          onTap: () {
                            if (formkay.currentState!.validate()) {
                              gender = registerCubit.get(context).gender;
                              registerCubit.get(context).UpDate(
                                    email: emailcontroller.text,
                                    address: addresscontroller.text,
                                    name: namecontroller.text,
                                    phone: phonecontroller.text,
                                    photo: image64.toString(),
                                    gender: gender.toString(),
                                    id: CachHelper.getData(key: "id"),
                                  );
                            }
                          },
                          text: "Edit",
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
                        text1: "reset password?",
                        size: 14,
                      ),
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
