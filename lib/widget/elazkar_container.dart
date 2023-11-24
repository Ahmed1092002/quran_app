import 'package:flutter/material.dart';

class ElazkarContainer extends StatelessWidget {
  String? text;
   ElazkarContainer({Key? key ,this.text}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
width: MediaQuery.of(context).size.width,
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(30),
  color: Theme.of(context).brightness == Brightness.dark ? Colors.white:Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(0, 3), // changes position of shadow
    ),
  ],
),alignment: Alignment.center,
      child: Text(
        text!,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ) ,

    );
  }
}
