import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  String? hint;
  IconData? icon;
  TextEditingController? controller;
  CustomTextField({Key? key,this.hint ='',this.icon,this.controller}) : super(key: key);

  bool passwordVisible=false;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          controller: controller,
          showCursor: true,
          enabled: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          toolbarOptions: ToolbarOptions(
            copy: true,
            cut: true,
            paste: true,
            selectAll: true,
          ),
cursorColor: Color(0xFFFA7131),

          validator: (value)
          {
            if(value!.isEmpty){
              return 'this field must not be empty';
            }
            if (hint == 'email') {
              if(!value.contains('@')){
                return 'this field must be a valid email';
              }
            }
            return null;
          },
          obscureText: passwordVisible,
          decoration: InputDecoration(
focusedBorder: UnderlineInputBorder(
  borderSide: BorderSide(color: Color(0xFFFA7131),width: 2),
),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black,width: 1),
              ),



              hintText: hint,

            hintStyle: const TextStyle(
                color: Color(0xFFD9D9D9),
                fontSize: 20,
                fontWeight: FontWeight.w500),


          )
      ),
    );
  }
}