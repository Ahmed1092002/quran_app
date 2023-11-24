import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quran_app/generated/assets.dart';
import 'package:quran_app/utils/navigator.dart';
import 'package:quran_app/views/MainScrean.dart';
import 'package:quran_app/views/login_sign_up_screan.dart';

class SpalshScrean extends StatefulWidget {
  const SpalshScrean({Key? key}) : super(key: key);

  @override
  _SpalshScreanState createState() => _SpalshScreanState();
}

class _SpalshScreanState extends State<SpalshScrean>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool _showContainer = false;
  var Token;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: const Duration(seconds: 2),

    );
    _controller!.forward().whenComplete(() async {
      setState(() {
        _showContainer = true;
      });
      Token = await storage.read(key: 'uid');
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (_, __, ___) {
           if (Token != null && FirebaseAuth.instance.currentUser != null ) {
              return MainScraen();
            }else {

              return LoginAndSignUpScrean();
           }
          },
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(

              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:AnimatedContainer(

curve: Curves.easeIn,

        duration: const Duration(milliseconds: 1000),
        width:  MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height ,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imageSplash),
            fit: BoxFit.cover,
          ),
        ),

      ),
    );
  }
}
