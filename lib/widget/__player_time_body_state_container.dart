import 'package:flutter/material.dart';

import '../generated/assets.dart';

class PlayerTimeBodyStateContainer extends StatelessWidget {
  String? salahName;
  String? salahTime;
bool ?isPlaying;
   PlayerTimeBodyStateContainer({
    super.key,
    this.salahName,
    this.salahTime,
    this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {  String? date;

  return Container(
      height: 70,
      width: 100,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurStyle: BlurStyle.outer,

            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (isPlaying == true)
          Image.asset(
            Assets.imageSpeakerFilledAudioTool,

            width: 30,
          ),

          Text(
            "${salahTime!}",
        textDirection: TextDirection.rtl
,
        style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            textDirection: TextDirection.rtl,
            salahName!,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
