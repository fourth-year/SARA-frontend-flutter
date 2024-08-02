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

class AddEmergency extends StatefulWidget {
  const AddEmergency({super.key});

  @override
  State<AddEmergency> createState() => _AddEmergencyState();
}

class _AddEmergencyState extends State<AddEmergency> {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    TextEditingController address = TextEditingController();
    TextEditingController description = TextEditingController();
    late TextEditingController contact = TextEditingController();
    ///////////////////////////////////////////////////////////////////////////
    final _picker = ImagePicker();
    File? _image;
    late String image64 = '';

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
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: text(
              text1: 'Add an Emergency',
              size: 22,
              fontWeight: FontWeight.w500,
            ),
            centerTitle: true,
          ),
          body: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(
                      text1:
                          "When you see an animal in an emergency, please notify us and we will take care of the situation.",
                      size: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 20,
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
                      height: 25,
                    ),
                    textfromfilde(
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
                      height: 25,
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
                      height: 30,
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
                                  ),
                                  child: Image(
                                    image: FileImage(
                                      File(_image!.path),
                                    ),
                                    fit: BoxFit.fill,
                                  ),
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
