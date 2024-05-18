import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/cubits_animals/cubit.dart';
import 'package:sara_front/cubits/cubits_animals/states.dart';

class Update_Animal extends StatefulWidget {
  Update_Animal({super.key});

  @override
  State<Update_Animal> createState() => _Update_AnimalState();
}

class _Update_AnimalState extends State<Update_Animal> {
  bool Dep_Error = false;

  bool Type_Error = false;

  TextEditingController name = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController Date = new TextEditingController();
  TextEditingController health = new TextEditingController();

  var formkay = GlobalKey<FormState>();

  // String date = '';
  var selected_type;

  var selected_Dep;

  DateTime? selectedDate;

  String? selectdate;

  final _picker = ImagePicker();

  File? _image;

  late String image64 = '';

  @override
  Widget build(BuildContext context) {
    ////////////////////// function image
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

    //////////////////// function date
    void _selectDateTime(BuildContext context) async {
      selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        initialDate: DateTime.now(),
      );
      if (selectedDate != null) {
        selectdate =
            "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
        AnimalCubit.get(context).selectdate(selectdate);
        print(selectdate);
        Date.text = selectdate.toString();
      }
    }

    return BlocConsumer<AnimalCubit, AnimalStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorApp.colorback,
            appBar: AppBar(
              backgroundColor: ColorApp.colorback,
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: text(
                    text1: 'Update the animal info',
                    size: 25,
                    color: ColorApp.color2,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 28),
                child: Form(
                  key: formkay,
                  child: Column(
                    children: [
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
                                    backgroundImage:
                                        FileImage(File(_image!.path)),
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(
                        height: 28,
                      ),
                      textfromfilde(
                        hint: 'Enter the name of the animal',
                        controller: name,
                        type: TextInputType.name,
                        color: ColorApp.color,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the name";
                          }
                        },
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      textfromfilde(
                        hint: 'Enter the age of the animal ',
                        controller: age,
                        type: TextInputType.number,
                        color: ColorApp.color,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the age";
                          }
                        },
                      ),
                      SizedBox(
                        height: 18,
                      ),

                      textfromfilde(
                        hint: "Date",
                        controller: Date,
                        ontap: () {
                          _selectDateTime(context);
                        },
                        readonly: true,
                        color: ColorApp.color3,
                        prefix: Icon(Icons.calendar_today),
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the date";
                          } else
                            return null;
                        },
                      ),

                      // TextField(
                      //   controller: Date,
                      //   onTap: () {
                      //     _selectDateTime(context);
                      //   },
                      //   readOnly: true,
                      //   decoration: InputDecoration(
                      //     hintText: "Date",
                      //     hintStyle: TextStyle(
                      //       fontSize: 14,
                      //       color: Colors.black87,
                      //     ),
                      //     prefixIcon: Padding(
                      //       padding: const EdgeInsets.only(left: 30, right: 10),
                      //       child: Icon(Icons.calendar_today),
                      //     ),
                      //     border: UnderlineInputBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     contentPadding: EdgeInsets.only(
                      //         left: 25, top: 15, bottom: 15, right: 30),
                      //     //لون المستطيل كامل
                      //     filled: true,
                      //     fillColor: ColorApp.color3,
                      //   ),
                      //
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: DropdownButtonFormField(
                            hint: Text(
                              'Choose the type of the animal',
                              style: TextStyle(
                                  color: ColorApp.color1, fontSize: 15),
                            ),
                            iconSize: 40,
                            icon: Icon(Icons.arrow_drop_down_rounded),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 30, top: 10, bottom: 10, right: 20),
                                filled: true,
                                fillColor: ColorApp.color,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide.none)),
                            value: selected_type,
                            dropdownColor: ColorApp.colorback,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            items: [
                              DropdownMenuItem(
                                child: Text("Cat"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("Dog"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text("Horse"),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                child: Text("Bird"),
                                value: 4,
                              ),
                              DropdownMenuItem(
                                child: Text("Donkey"),
                                value: 5,
                              )
                            ],
                            onChanged: (value) {
                              AnimalCubit.get(context).Select_type(value);
                              selected_type = AnimalCubit.get(context).type_num;
                              value = selected_type;
                              Type_Error = false;
                            }),
                      ),

                      Type_Error
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
                        padding: const EdgeInsets.only(top: 18),
                        child: DropdownButtonFormField(
                          hint: Text(
                            'Choose the Departement',
                            style:
                                TextStyle(color: ColorApp.color1, fontSize: 15),
                          ),
                          iconSize: 40,
                          icon: Icon(Icons.arrow_drop_down_rounded),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: ColorApp.color,
                              contentPadding: EdgeInsets.only(
                                  left: 30, top: 10, bottom: 10, right: 20),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide.none,
                              )),
                          value: selected_Dep,
                          dropdownColor: ColorApp.colorback,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          items: const [
                            DropdownMenuItem(
                              child: Text("Department_1"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("Department_2"),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text("Department_3"),
                              value: 3,
                            ),
                            DropdownMenuItem(
                              child: Text("Department_4"),
                              value: 4,
                            ),
                            DropdownMenuItem(
                              child: Text("Department_5"),
                              value: 5,
                            )
                          ],
                          onChanged: (value) {
                            AnimalCubit.get(context).Select_Dep(value);
                            selected_Dep = AnimalCubit.get(context).Dep_num;
                            value = selected_Dep;
                            Dep_Error = false;
                          },
                        ),
                      ),

                      Dep_Error
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
                        padding: const EdgeInsets.only(top: 40),
                        child: defaultButton(
                          onTap: () {
                            print(selected_Dep);
                            print(selected_type);

                            if (selected_type != null) {
                              Type_Error = false;
                              AnimalCubit.get(context).m_error(Type_Error);
                              Type_Error = AnimalCubit.get(context).error;
                            } else {
                              Type_Error = true;
                              AnimalCubit.get(context).m_error(Type_Error);
                              Type_Error = AnimalCubit.get(context).error;
                            }

                            if (selected_Dep != null) {
                              Dep_Error = false;
                              AnimalCubit.get(context).m_errorD(Dep_Error);
                              Dep_Error = AnimalCubit.get(context).errorD;
                            } else {
                              Dep_Error = true;
                              AnimalCubit.get(context).m_errorD(Dep_Error);
                              Dep_Error = AnimalCubit.get(context).errorD;
                            }

                            if (formkay.currentState!.validate()) {
                              if (selected_Dep != null) {
                                Dep_Error = false;
                                AnimalCubit.get(context).m_error(Dep_Error);
                                Dep_Error = AnimalCubit.get(context).error;
                              } else {
                                Dep_Error = true;
                                AnimalCubit.get(context).m_error(Dep_Error);
                                Dep_Error = AnimalCubit.get(context).error;
                              }
                              if (formkay.currentState!.validate() &&
                                  selected_type != null &&
                                  selected_Dep != null) {
                                AnimalCubit.get(context).UpdateAnimal(
                                    id: 'id',
                                    name: name.text,
                                    age: int.parse(age.text),
                                    date: AnimalCubit.get(context).selectDate,
                                    type: selected_type,
                                    Dep: selected_Dep,
                                    health: "unhealthy",
                                    photo: image64.toString());
                              }
                            }

                            print(AnimalCubit.get(context).selectDate);
                          },
                          text: "Update",
                          textColor: Colors.white,
                          color: ColorApp.color2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
