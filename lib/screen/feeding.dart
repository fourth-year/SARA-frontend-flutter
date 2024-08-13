import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/screen/Jops.dart';
import '../components/textButton.dart';
import '../cubits/cubits_animals/cubit.dart';
import '../cubits/cubits_animals/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../components/colors.dart';
import '../components/text.dart';
import 'layout.dart';

class Feeding extends StatefulWidget {
  @override
  State<Feeding> createState() => _FeedingState();
}

class _FeedingState extends State<Feeding> {
  void initState() {
    super.initState();
    AnimalCubit.get(context).feedingAnimal();
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimalCubit, AnimalStates>(
      listener: (context, state) {
        if (state is CanFeedingErrorState) {
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
          AnimalCubit.get(context).feedingAnimal();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Feeding()));
        }
        if (state is CanFeedingSuccessState) {
          AnimalCubit.get(context).feedingAnimal();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Feeding()),
          );
        }
      },
      builder: (context, state) {
        if (AnimalCubit.get(context).feeding_modle != null &&
            state is FeedingSuccessState) {
          print('feed');
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Layout()),
                  );
                },
                icon: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
              title: text(
                themestyle: Theme.of(context).textTheme.headline5,

                text1: 'Feeding',
                color: ColorApp.color2,
                size: 22,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 2.5,
                      children: List.generate(
                        AnimalCubit.get(context).feeding_modle!.data.length,
                        (index) => builditem(
                            AnimalCubit.get(context).feeding_modle!.data[index],
                            context,
                            index),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          print('not feed');
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Layout()),
                    );
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
                title: text(
                  themestyle: Theme.of(context).textTheme.headline5,

                  text1: 'Feeding',
                  color: ColorApp.color2,
                  size: 22,
                ),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }

  Widget builditem(dynamic model, context, index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        // elevation: 3.0,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20.0),
        // ),
        // // shadowColor:Colors.black,
        // surfaceTintColor: ColorApp.color2,
        //
        // borderOnForeground: false,

        child: Container(
          decoration: BoxDecoration(
              // color: ColorApp.colorback,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                            text1: "Name : ${model!.name}",
                            size: 20,
                            fontWeight: FontWeight.w200,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          text(
                            text1: " the time  : 9:00 am",
                            size: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: () {
                    dynamic dep;
                    if (model.name == "Department 1") {
                      dep = 1;
                    }
                    if (model.name == "Department 2") {
                      dep = 2;
                    }
                    if (model.name == "Department 3") {
                      dep = 3;
                    }
                    if (model.name == "Department 4") {
                      dep = 4;
                    }
                    if (model.name == "Department 5") {
                      dep = 5;
                    }
                    if (model.name == "Department 6") {
                      dep = 6;
                    }
                    if (model.name == "Department 7") {
                      dep = 7;
                    }
                    if (model.name == "Department 8") {
                      dep = 8;
                    }
                    if (model.name == "Department 9") {
                      dep = 9;
                    }
                    if (model.name == "Department 10") {
                      dep = 10;
                    }

                    openFeedingDialog(context, dep);
                    print(model.name);
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////
  openFeedingDialog(BuildContext context, dynamic i) {
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
            content: Padding(
              padding: const EdgeInsets.all(5.0),
              child: text(
                text1: 'Are you sure you can complete the task?',
                color: ColorApp.color2,
              ),
            ),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            actions: [
              textButton(
                  text: 'Cancel',
                  onTap: () {
                    Navigator.pop(context);
                  }),
              textButton(
                  text: 'yes',
                  color: ColorApp.color2,
                  onTap: () {
                    int id = int.parse(CachHelper.getData(key: "id"));
                    AnimalCubit.get(context).Can_Feeding(id: id, id_dep: i);
                    // Navigator.push(context, MaterialPageRoute(builder:(context)=> Feeding()));
                  })
            ],
          ),
        );
      },
    );
  }
}
