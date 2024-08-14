import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/Emergencies/cubit/emergency_cubit.dart';

import 'layout.dart';

class AddEmergency extends StatefulWidget {
  const AddEmergency({super.key});

  @override
  State<AddEmergency> createState() => _AddEmergencyState();
}

class _AddEmergencyState extends State<AddEmergency> {

  var formkey = GlobalKey<FormState>();
  TextEditingController address = TextEditingController();
  TextEditingController description = TextEditingController();
  late TextEditingController contact = TextEditingController();
  ///////////////////////////////////////////////////////////////////////////
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

//////////////////////////////////////////////////////////////////////////////////
    return BlocConsumer<EmergencyCubit, EmergencyState>(
      listener: (context, state) {
      if (state is EmergencyAddedSuccessfully) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Text(
                'Case recorded',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(), // Add a spacer to push the icon to the end
              Icon(Icons.check, color: Colors.green),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          // showCloseIcon: true,
          // closeIconColor: Colors.black,
          backgroundColor: ColorApp.colorback,
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Layout()),
        );
      }

      if (state is EmergencyAddedError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Error happened, try again',
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
          appBar: AppBar(
            title: text(
              themestyle: Theme.of(context).textTheme.headline5,
              text1: 'Add an Emergency',
            color: ColorApp.color2,
            size: 22,
          ),
            leading: IconButton(onPressed: () {
              Navigator.pop(context);

            }, icon: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Icon(Icons.arrow_back_ios),
            ),),

          ),
          body: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15,top: 15),
                      child: text(
                        text1:
                            "When you see an animal in an emergency, please notify us and we will take care of the situation.",
                        size: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: textfromfilde(
                        size: 13,
                        hint: 'Enter the address',
                        controller: address,
                        type: TextInputType.name,
                        color: Color.fromARGB(255, 219, 229, 244),
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the address";
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    textfromfilde(
                      count: 10,
                      size: 13,
                      hint: 'Enter your number',
                      controller: contact,
                      type: TextInputType.number,
                      color: Color.fromARGB(255, 219, 229, 244),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: description,
                      minLines: 2,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        hintText: 'Description of the situation...',
                        hintStyle:
                            TextStyle(fontSize: 13, color: Colors.black87),
                        filled: true,
                        fillColor: Color.fromARGB(255, 219, 229, 244),
                        contentPadding: EdgeInsets.only(
                            left: 25, top: 18, bottom: 18, right: 30),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          _openImagePicker();
                        },
                        child: _image == null
                            ? Stack(children: [
                                DottedBorder(
                                  color: Colors.black38,
                                  strokeWidth: 2,
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(8),
                                  child: Container(
                                    height: 200,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      shape: BoxShape.rectangle,
                                      color: Colors.white12,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 85,
                                  left: 135,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 35,
                                    color: Colors.black38,
                                  ),
                                ),
                              ])
                            : DottedBorder(
                                color: Colors.black38,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8),
                                child: Container(
                                  width: 300,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    shape: BoxShape.rectangle,
                                    color: Colors.white12,
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(_image!.path),
                                        ),
                                        fit: BoxFit.fill,
                                      )
                                  ),
                                  // child: Image(
                                  //   image: FileImage(
                                  //     File(_image!.path),
                                  //   ),
                                  //   fit: BoxFit.fill,
                                  // ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: defaultButton(
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            EmergencyCubit.get(context).addEmergency(
                                address: address.text,
                                description: description.text,
                                contact: contact.text,
                                photo: image64.toString());
                          }
                        },
                        text: "Send",
                        textColor: Colors.white,
                        color: ColorApp.color2,
                        h: 50,
                        w: 100,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
