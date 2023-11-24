import 'package:flutter/material.dart';

class LoginWithFaceBookButtom extends StatelessWidget {
  final String?buttonName;
  final void Function()? onPressed;
  const  LoginWithFaceBookButtom({
    super.key,
    this.buttonName,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(400, 50),
          elevation: 5,
          backgroundColor: Color(0xFF333333),

          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Icon(Icons.facebook, color: Colors.white,),
          SizedBox(width: 10,),
          Text(
            'Login with Facebook',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      )
    );
  }
}