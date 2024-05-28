import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/components/text.dart';
import 'package:sara_front/cubits/cubit/app_cubit.dart';
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
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AppInitial) {
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 80),
              child: text(
                text1: 'Settings'.tr(),
                size: 28,
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
                      padding: EdgeInsets.all(5.0),
                      child: ListTile(
                        title: text(
                          text1: 'Dark mode'.tr(),
                          fontWeight: FontWeight.w400,
                          size: 20,
                        ),
                        trailing: Switch(value: value, onChanged: (value) {}),
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
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 25, top: 15, bottom: 12, right: 20),
                          filled: true,
                          fillColor: Color.fromARGB(255, 228, 233, 244),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                      value: selected_language,
                      dropdownColor: Color.fromARGB(255, 228, 239, 244),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      items: ["English".tr(), "Arabic".tr()]
                          .map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        AppCubit.get(context).Select_Language(value);
                        selected_language = AppCubit.get(context).Language;
                        if (selected_language == "English") {
                          context.setLocale(Locale('en'));
                        } else if (selected_language == 'Arabic') {
                          context.setLocale(Locale('ar'));
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
