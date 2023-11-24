import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../src/app_root.dart';

class DarkModeSwitch extends StatelessWidget {

   DarkModeSwitch({
    super.key,

  });

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        'Dark mode',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w100,
          color: Colors.white,
        ),
      ),
      FlutterSwitch(
        width: 70.0,
        height: 35.0,
        toggleSize: 29.0,
        value: Theme.of(context).brightness == Brightness.dark,
        borderRadius: 30.0,
        padding: 2.0,
        showOnOff: true,

        activeColor:  Colors.white,
        activeToggleColor: Colors.white,
        inactiveToggleColor: Colors.white,
        activeSwitchBorder: Border.all(
          color: Color(0xFFFA7031),
          width: 1.0,
        ),
        inactiveSwitchBorder: Border.all(
          color:Color(0xFFFA7031),
          width: 1.0,
        ),
        activeToggleBorder: Border.all(
          color: Color(0xFFFA7031),
          width: 1.0,
        ),
        inactiveToggleBorder: Border.all(
          color: Color(0xFFFA7031),
          width: 1.0,
        ),
        activeText: "ON",
        inactiveText: "OFF",
        activeTextColor: Color(0xFFFA7031),
        inactiveTextColor: Color(0xFFFA7031),

        activeTextFontWeight: FontWeight.w100,
        inactiveTextFontWeight: FontWeight.w100,

        inactiveColor: Colors.white,


        onToggle: (val) {
          MyApp.themeNotifier.value =
          MyApp.themeNotifier.value == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light;

    }
    ),

    ]);
  }
}
