import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/cubits/app/state_app.dart';
import 'package:sara_front/network/cach_helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var selected_language;
    bool value = false;
    return Scaffold(
      appBar: AppBar(
        title: text(
          themestyle: Theme.of(context).textTheme.headline5,
          text1: 'Settings'.tr(),
          size: 28,
          color: ColorApp.color2,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20),
            child: Icon(Icons.arrow_back_ios),
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
                color: Color.fromARGB(255, 219, 229, 244),
                // color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ListTile(
                    title: text(
                      themestyle: Theme.of(context).textTheme.subtitle1,
                      text1: 'Dark mode'.tr(),
                      fontWeight: FontWeight.w400,
                      size: 20,
                    ),
                    trailing: Switch(
                        activeColor: Colors.blue,
                        value: AppCubit.get(context).isdark,
                        onChanged: (value) {
                          setState(() {
                            AppCubit.get(context).changthem(value);
                          });
                        }),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 5, right: 5),
              child: DropdownButtonFormField(
                  hint: Text(
                    'Choose the Language',
                    style: TextStyle(color: ColorApp.color1, fontSize: 13),
                  ),
                  iconSize: 40,
                  icon: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Theme.of(context).brightness == Brightness.light
                        ? ColorApp.color2 // لون المظهر الخفيف
                        : Colors.grey[800] ?? ColorApp.color2,
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 25, top: 15, bottom: 12, right: 20),
                      filled: true,
                      fillColor: Color.fromARGB(255, 228, 233, 244),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  value: selected_language,
                  dropdownColor: ColorApp.colorback,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  items: ["English", "Arabic"]
                      .map((e) => DropdownMenuItem(
                            child: Text("$e"),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (context.locale.languageCode == "en") {
                      context.setLocale(Locale('ar'));
                    } else {
                      context.setLocale(Locale('en'));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
