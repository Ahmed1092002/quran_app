import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/utils/navigator.dart';
import 'package:quran_app/views/setting_screan.dart';
import 'package:quran_app/widget/dark_mode_switch.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: [
          DropdownMenuItem(
            value: '1',
            child: DarkModeSwitch(),
          ),
          DropdownMenuItem(
            value: '2',
            child: InkWell(
                onTap: () {
                  navigateToScreen(context, SettingScrean());

                },
                child: Container(
                  width: 200,

                    child: Text('الاعدادات'))),
          ),
          DropdownMenuItem(
            value: '3',
            child: Text('مساعدة'),
          ),
          DropdownMenuItem(
            value: '4',
            child: Text('عنا'),
          ),

        ],
        customButton: const Icon(
          Icons.list,
          size: 46,
          color: Color(0xFFFA7031),
        ),
        onChanged: (value) {},
        dropdownStyleData: DropdownStyleData(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(0xFF333333),
          ),
          offset: const Offset(0, 8),
        ),
      ),
    );
  }
}
