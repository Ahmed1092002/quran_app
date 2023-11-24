import 'package:flutter/material.dart';
import 'package:quran_app/generated/assets.dart';
import 'package:quran_app/views/login_body.dart';
import 'package:quran_app/views/sign_up_body.dart';

import '../widget/tab_widget.dart';

class LoginAndSignUpScrean extends StatefulWidget {
  const LoginAndSignUpScrean({Key? key}) : super(key: key);

  @override
  State<LoginAndSignUpScrean> createState() => _LoginAndSignUpScreanState();
}

class _LoginAndSignUpScreanState extends State<LoginAndSignUpScrean> {
  int _currentIndex = 0;

  void _handleIndexChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
      List<Widget> _widgetOptions = <Widget>[
      LoginBody(),
     SignUpBody()

    ];
  return  Scaffold(
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Image.asset(Assets.imageLogo, width: 150),
              const SizedBox(height:20,),
              TabWidget( onIndexChanged: _handleIndexChanged),
              Container(

                  width: MediaQuery.of(context).size.width/1.1,

           child: Column(
              children:[ _widgetOptions[_currentIndex]]
           ),
              ),

                    ]
                  ),
        ),
      )
    );
  }
}
