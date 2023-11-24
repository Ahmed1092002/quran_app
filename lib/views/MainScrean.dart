import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:quran_app/my_flutter_app_icons.dart' as IconData;
import 'package:quran_app/views/player_time_body.dart';
import 'package:quran_app/widget/shared_app_bar.dart';

import 'el_quran_body.dart';
import 'elazkar_body.dart';
import 'elqepla_body.dart';

class MainScraen extends StatefulWidget {
  const MainScraen({super.key});

  @override
  State<MainScraen> createState() => _MainScraenState();
}

class _MainScraenState extends State<MainScraen> {
  int _currentIndex = 0;
  void _handleIndexChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    PlayerTimeBody(),
    Text('tamer'),
    ElqeplaBody(),
    ElazkarBody(),
    ElquranBody(),
  ];
  @override
  Widget build(BuildContext context) {
    int _bottomNavIndex = 0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(38),
        child: SharedAppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        //shape of button
        onPressed: () {
          setState(() {
            _bottomNavIndex = 4;
            _handleIndexChanged(_bottomNavIndex);
          });
        },
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xFFFA7031), Color(0xFFED3927)],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight)),
            child: Icon(
              IconData.MyFlutterApp.quran,
              color: Colors.white,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          Icons.home,
          Icons.favorite,
          Ionicons.compass_outline,
          IconData.MyFlutterApp.doaa,
        ],

        splashSpeedInMilliseconds: 100,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        backgroundGradient: LinearGradient(
            colors: [Color(0xFFFA7031), Color(0xFFED3927)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        rightCornerRadius: 30,
        leftCornerRadius: 30,
        iconSize: 30,
        activeColor: Colors.white,
        inactiveColor: Colors.white,

        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            _handleIndexChanged(_bottomNavIndex);
          });
        },
        //other params
      ),
      body: _widgetOptions[_currentIndex],
    );
  }
}
