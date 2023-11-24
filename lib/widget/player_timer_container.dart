import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/blocs/PrayerTimes/prayer_times_api_cubit.dart';

class PlayerTimerContainer extends StatelessWidget {
  const PlayerTimerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrayerTimesApiCubit ,PrayerTimesApiState >(
  listener: (context, state) {
   if (state is PrayerTimesApiSuccess) {
 // PrayerTimesApiCubit.get(context).nextTimer();
    }
  },
  builder: (context, state) {

    var cubit=PrayerTimesApiCubit.get(context);
    return StreamBuilder(
      stream: cubit.startTimer(),
      builder: (context, snapshot) {
if (cubit.remainingTime.toString().split('.').first!=null) {

  return Container(
    width: MediaQuery.of(context).size.width / 1.1,
    height: 100,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient:LinearGradient(colors: [Color(0xFFFA7031), Color(0xFFED3927)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          )
        ]),
    child: Column(
      children: [
        Text(
          'باقي علي صلاة ${cubit.prayerNameString}',
          
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        Text(
          '${cubit.remainingTime.toString().split('.').first}',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );



}
else {
  return Container();
}



      }
    );
    // return Container(
    //     width: MediaQuery.of(context).size.width / 1.1,
    //     height: 100,
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(20),
    //          gradient:LinearGradient(colors: [Color(0xFFFA7031), Color(0xFFED3927)],
    //          begin: Alignment.topCenter,
    //          end: Alignment.bottomCenter,
    //          ),
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.grey.withOpacity(0.5),
    //             spreadRadius: 5,
    //             blurRadius: 7,
    //             offset: const Offset(0, 3), // changes position of shadow
    //           )
    //         ]),
    //
    //     child: Column(
    //
    //       mainAxisAlignment: MainAxisAlignment.center,
    //         children: const [
    //           Text(
    //             'باقي علي صلاة المغرب',
    //             style: TextStyle(
    //                 fontSize: 30,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.white),
    //           ),
    //           Text(
    //             '${cubit.timer}',
    //             style: TextStyle(
    //               fontSize: 30,
    //               color: Colors.white,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ]));
  },
);
  }
}
