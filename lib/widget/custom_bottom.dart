import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String?buttonName;
  final void Function()? onPressed;
  const  CustomButton({
    super.key,
    this.buttonName,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {

    return   GestureDetector(

      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
                colors: [Color(0xFFFA7031), Color(0xFFED3927)],
          begin: Alignment.topLeft,
          end: Alignment.topRight

          )
        ),

        child: Center(
          child: Text(
            buttonName!,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
    return ElevatedButton(
      onPressed: onPressed,

      style: ElevatedButton.styleFrom(
          minimumSize: Size(400, 50),

          backgroundColor: Color(0xFFFA7131),
          elevation: 5,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)) ),
      child: Text(
        buttonName!,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}