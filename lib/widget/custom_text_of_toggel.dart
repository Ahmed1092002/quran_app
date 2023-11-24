import 'package:flutter/material.dart';

class CustomTextOfToggel extends StatefulWidget {
  String? text;
  int index ;

  final ValueChanged<int> onIndexChanged;
  final ValueChanged<int> handleBodyIndexChanged;

  List<Color> itemColors ;
  final Function(String) onSelected;
  final bool isSelected;

  CustomTextOfToggel({
    super.key,
    this.text,
    required this.onSelected,
    required this.itemColors,
    this.index = 0,
    this.isSelected = false,
    required this.onIndexChanged,
    required this.handleBodyIndexChanged,
  });

  @override
  State<CustomTextOfToggel> createState() => _CustomTextOfToggelState();
}

class _CustomTextOfToggelState extends State<CustomTextOfToggel> {

  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected; // Initialize isSelected from widget parameter
  }
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          isSelected = widget.isSelected;
          setState(() {
            isSelected = !isSelected;
            widget.onSelected(widget.text!);
            widget.onIndexChanged(widget.index);
            widget.handleBodyIndexChanged(widget.index);


          });


        },
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors:  isSelected
                  ? [Color(0xFFFA7031), Color(0xFFF3542C)]

                  : [Colors.black, Colors.black],
            ).createShader(rect);
          },
          child: Text(
            widget.text!,
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: widget.itemColors[widget.index] == Colors.white
                  ?

              Colors.white : Colors.black,
              shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black12,
                ),
              ],
            ),
          )
        ));
  }
}
