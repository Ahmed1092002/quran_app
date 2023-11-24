import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String? text;
   CustomText({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return                     ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [Color(0xFFFA7031), Color(0xFFF3542C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
      child: Text(
        text!,
textDirection: TextDirection.rtl,

        style: TextStyle(
          fontSize: 40,
          shadows: [
            Shadow(
              blurRadius: 10.0,

              color: Colors.black26,

            ),
          ],
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),


    );

  }
}
