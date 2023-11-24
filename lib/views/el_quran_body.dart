import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/blocs/ElquranCubit/elquran_cubit.dart';
import 'package:quran_app/generated/assets.dart';
import 'package:quran_app/views/surah_body.dart';
import 'package:quran_app/widget/elquran_body_toggle_buttons.dart';
import 'package:flutter/material.dart';

import 'elquran_player_body.dart';
import 'jus_body.dart';

class ElquranBody extends StatefulWidget {
   ElquranBody({Key? key}) : super(key: key);

  @override
  State<ElquranBody> createState() => _ElquranBodyState();
}

class _ElquranBodyState extends State<ElquranBody> {
int SelectedIndex = 2;
void _handleBodyIndexChanged(int index) {
  setState(() {
    SelectedIndex = index;
  });
}
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [

      ElquranPlayerBody(),
      JusBody(),
      SurahBody(),


    ];
    return BlocProvider(
  create: (context) => ElquranCubit(),
  child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),

          ),

          child: Column(

            children: [
              Image.asset(Assets.imageLogo,fit: BoxFit.cover,width: MediaQuery.of(context).size.width*0.3,
              height: MediaQuery.of(context).size.height/9,
              ),
              SizedBox(height: 15,),

              ElquranBodyToggleButtons(
                onIndexChanged:_handleBodyIndexChanged,
              ),



              Container(
                height: MediaQuery.of(context).size.height*0.6,

                child:items[SelectedIndex] ,
              ),
            ],
          ),



        )


    ),
);
  }
}

