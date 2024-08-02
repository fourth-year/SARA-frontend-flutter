import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/cubits/Emergencies/cubit/emergency_cubit.dart';
import 'package:sara_front/network/end_point.dart';
import 'package:sara_front/screen/add_emergency.dart';

class Emergencies extends StatelessWidget {
  const Emergencies({super.key});

  @override
  Widget build(BuildContext context) {
    EmergencyCubit.get(context).getAll_Emergencies(status:1 );
    return BlocConsumer<EmergencyCubit, EmergencyState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (role_id == '1') {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEmergency(),
                    ));
              },
              backgroundColor: ColorApp.color2,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            // body: Expanded(child: ListView.separated(itemBuilder: (context, index) {

            // }, separatorBuilder: (context, index) => SizedBox(height: 8,), itemCount: )),
          );
        } else if (role_id == '4' &&
            state is GetAllEmergenciesSuccessfully) {
          return Scaffold(
            appBar: AppBar(),
            // body: Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Expanded(
            //     child: ListView.separated(
            //         itemBuilder: (context, index) {},
            //         separatorBuilder: (context, index) => SizedBox(
            //               height: 10,
            //             ),
            //         itemCount: EmergencyCubit.get(context)
            //             .get_all_Accepted_emergencies?.data.length),
            //   ),
            // ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                'There are no emergencies',
                style: TextStyle(fontSize: 17),
              ),
            ),
          );
        }
      },
    );
  }
}
