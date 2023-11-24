import 'package:flutter/material.dart';
import 'package:quran_app/model/ElazkarModel.dart';

import '../widget/shared_app_bar.dart';

class ElazkarScrean extends StatefulWidget {
  String? Title;
  List<Array>? Description;
   ElazkarScrean({Key? key
   ,this.Title
     ,this.Description
   }) : super(key: key);

  @override
  _ElazkarScreanState createState() => _ElazkarScreanState();
}

class _ElazkarScreanState extends State<ElazkarScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(60),
        child:SharedAppBar(
          Titel: widget.Title,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: ListView.builder(
                itemCount: widget.Description!.length,
                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.Description![index].text!,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),

            ),
          ),
        ),
      ),
    ) ;
  }
}
