import 'package:flutter/material.dart';
import 'package:quran_app/widget/custom_text_of_toggel.dart';

class ElquranBodyToggleButtons extends StatefulWidget {
  final ValueChanged<int> onIndexChanged;

   ElquranBodyToggleButtons({
    super.key,
    required this.onIndexChanged,
  });

  @override
  State<ElquranBodyToggleButtons> createState() =>
      _ElquranBodyToggleButtonsState();
}

class _ElquranBodyToggleButtonsState extends State<ElquranBodyToggleButtons> {
  List<Color> itemColors = List.generate(3, (index) => Colors.white);
  int selectedIndex = 2;
  void _handleIndexChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  List <String> items = [
    'الشيوخ'
    ,'الأجزاء',
    'السور'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.89,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
color: Theme.of(context).brightness == Brightness.dark ? Colors.white:Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: ListView.separated(
          scrollDirection:  Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.all(8),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextOfToggel(
                  text: items[index],
                  onIndexChanged:_handleIndexChanged,
                  handleBodyIndexChanged: widget.onIndexChanged,

                  itemColors: itemColors,
                  index: index,
                  isSelected: selectedIndex == index,
                  onSelected: (value) {
                    setState(() {
                      selectedIndex = index;
                      itemColors = List.generate(itemColors.length, (i)
                      => i == index ? Colors.white : Colors.black);
                    });
                  },
                ),

              ],
            ),
            separatorBuilder: (context, index) => VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  width: 20,
                  endIndent: 10,
                  indent: 10,
                ),
            itemCount: 3

        ),
      ),
    );
  }
}
