import 'package:flutter/material.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool value = false;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 80),
          child: text(
            text1: 'Settings',
            size: 25,
            color: ColorApp.color2,
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 10, left: 25, right: 25),
        child: Column(
          children: [
            Container(
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: text(
                            text1: 'Dark mode',
                            fontWeight: FontWeight.w400,
                            size: 20,
                          )),
                      Switch(value: value, onChanged: (value) {
                        
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
