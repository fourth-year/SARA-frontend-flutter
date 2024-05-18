import 'package:flutter/material.dart';
import 'package:sara_front/cubits/cubits_animals/cubit.dart';
import 'package:sara_front/network/end_point.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontSize: 14),
          unselectedLabelStyle: TextStyle(fontSize: 13),
          elevation: 5.5,
          type: BottomNavigationBarType.fixed,
          currentIndex: AnimalCubit.get(context).curentindex,
          onTap: (index) {
            setState(() {
              AnimalCubit.get(context).changBottom(index);
            });
          },
          items: role_id == "2"
              ? [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.grid_view_rounded,
                      ),
                      label: 'Animals'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_filled,
                      ),
                      label: 'Add'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_filled,
                      ),
                      label: 'home'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.medical_services,
                      ),
                      label: 'emergencies'),
                ]
              : [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.grid_view_rounded,
                      ),
                      label: 'Animals'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_filled,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.medical_services,
                      ),
                      label: 'emergencies'),
                ]),
      body:
          AnimalCubit.get(context).screen[AnimalCubit.get(context).curentindex],
    );
  }
}
