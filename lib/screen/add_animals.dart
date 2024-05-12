import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/defaultButton.dart';
import 'package:sara_front/components/textfromfilde.dart';
import 'package:sara_front/cubits/cubits_animals/cubit.dart';
import 'package:sara_front/cubits/cubits_animals/states.dart';
import '../components/colors.dart';
import '../components/text.dart';
import '../components/colors.dart';


class AddAnimal extends StatefulWidget {
  const AddAnimal({super.key});

  @override
  State<AddAnimal> createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = new TextEditingController();
    TextEditingController age = new TextEditingController();
    // TextEditingController date = new TextEditingController();
    String date='';
    var selected_type;
    var selected_Dep;
    DateTime? selectedDate;
    String? selectdate;
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
      }
    }

    return BlocConsumer<AnimalCubit, AnimalStates>(
        listener: (context, state) {},
    builder: (context, state) {

      return
         Scaffold(
      backgroundColor: ColorApp.colorback,
      appBar: AppBar(
        backgroundColor: ColorApp.color2,
        title: Center(
          child: text(
            text1: 'Add an animal',
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 28),
          child: Column(
            children: [
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
                height: 25,
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
                height: 25,
              ),
              // textfromfilde(
              //   hint: 'Enter the date you ',
              //   controller: date,
              //   type: TextInputType.number,
              //   color: ColorApp.color,
              //   validate: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Please enter the date";
              //     }
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: DropdownButtonFormField(
                    hint: Text(
                      'Choose the type of the animal',
                      style: TextStyle(color: ColorApp.color1, fontSize: 15),
                    ),
                    iconSize: 40,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 30, top: 10, bottom: 10, right: 20),
                        filled: true,
                        fillColor: ColorApp.color,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide.none)),
                    value: selected_type,
                    dropdownColor: ColorApp.colorback,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    items: [DropdownMenuItem(
                      child: Text("Cat"),
                      value: 1,
                    ),DropdownMenuItem(
                      child: Text("Dog"),
                      value: 2,
                    ),DropdownMenuItem(
                      child: Text("Horse"),
                      value: 3,
                    ),DropdownMenuItem(
                      child: Text("Bird"),
                      value: 4,
                    ),DropdownMenuItem(
                      child: Text("Donkey"),
                      value: 5,
                    )],
                    onChanged: (value) {
                      AnimalCubit.get(context).Select_type(value);
                      selected_type = AnimalCubit.get(context).type_num;
                      value=selected_type;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: DropdownButtonFormField(
                  hint: Text(
                    'Choose the Departement',
                    style: TextStyle(color: ColorApp.color1, fontSize: 15),
                  ),
                  iconSize: 40,
                  icon: Icon(Icons.arrow_drop_down_rounded),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorApp.color,
                      contentPadding: EdgeInsets.only(
                          left: 30, top: 10, bottom: 10, right: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide.none,
                      )),
                  value: selected_Dep,
                  dropdownColor: ColorApp.colorback,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  items:const  [DropdownMenuItem(
                            child: Text("Department_1"),
                            value: 1,
                          ),DropdownMenuItem(
                    child: Text("Department_2"),
                    value: 2,
                  ),DropdownMenuItem(
                    child: Text("Department_3"),
                    value: 3,
                  ),DropdownMenuItem(
                    child: Text("Department_4"),
                    value: 4,
                  ),DropdownMenuItem(
                    child: Text("Department_5"),
                    value: 5,
                  )],
                   onChanged: (value) {
                    AnimalCubit.get(context).Select_Dep(value);
                    selected_Dep = AnimalCubit.get(context).Dep_num;
                    value=selected_Dep;
                   },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: defaultButton(
                  onTap: () {
                    AnimalCubit.get(context).addAnimal(
                        date: selectdate,
                        name: name.text,
                        age: int.parse(age.text),
                        type:selected_type,
                        Dep: selected_Dep);
                    print(AnimalCubit.get(context).selectDate);
                  },
                  text: "Add",
                  textColor: Colors.white,
                  color: ColorApp.color2,
                ),
              ),
              TextButton(
                  onPressed: () {
                    _selectDateTime(context);

                  },
                  child: Text("send date"))
            ],
          ),
        ),
      ),
    );
  });}
}
