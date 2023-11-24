import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class TabWidget extends StatefulWidget {
  final ValueChanged<int> onIndexChanged;
   TabWidget({Key? key, required this.onIndexChanged}) : super(key: key);

  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
   ValueNotifier<int> _tabIconIndexSelected = ValueNotifier(0);

  List<String> get listTextTabToggle =>
      ["Login", " Sign Up"];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _tabIconIndexSelected,
        builder: (context, currentIndex, _) {
          return FlutterToggleTab(


            width: 90,
            borderRadius: 15,
            isShadowEnable: false,

            height: 50,
            selectedIndex: currentIndex,
unSelectedBackgroundColors: [Colors.white],

            selectedBackgroundColors: [Colors.white],

            selectedTextStyle: TextStyle(
              color: Color(0xFFFA7131),
                fontSize: 25,
                fontWeight: FontWeight.w700),
            unSelectedTextStyle: TextStyle(
                color: Color(0xFFD9D9D9),
                fontSize: 25,
                fontWeight: FontWeight.w500),
            labels:listTextTabToggle,
            selectedLabelIndex: (index) {

              setState(() {
                _tabIconIndexSelected.value = index;
                widget.onIndexChanged(index);
              });



            },
            isScroll: true,

          );
        });
  }
  }

