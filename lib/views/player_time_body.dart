import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/blocs/PrayerTimes/prayer_times_api_cubit.dart';
import 'package:quran_app/widget/player_timer_container.dart';

import '../widget/__player_time_body_date.dart';
import '../widget/__player_time_body_state_container.dart';

class PlayerTimeBody extends StatefulWidget {
  const PlayerTimeBody({Key? key}) : super(key: key);

  @override
  _PlayerTimeBodyState createState() => _PlayerTimeBodyState();
}

class _PlayerTimeBodyState extends State<PlayerTimeBody>with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    PrayerTimesApiCubit.get(context).startTimer();

    WidgetsBinding.instance!.addObserver(this);


  }
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      PrayerTimesApiCubit.get(context).startTimer();
    } else if (state == AppLifecycleState.resumed) {
      PrayerTimesApiCubit.get(context).startTimer();

    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesApiCubit, PrayerTimesApiState>(
    builder: (context, state) {
      if ( PrayerTimesApiCubit.get(context).playerTimesModel == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column( children: [
              PlayerTimeBodyDate(),
              const SizedBox(
                height: 20,
              ),
              PlayerTimerContainer(),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<PrayerTimesApiCubit, PrayerTimesApiState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      var cubit = PrayerTimesApiCubit.get(context);

      if (cubit == null) {
        return  Center(
          child: CircularProgressIndicator(),
        );
      }

      return Container(
                height: MediaQuery.of(context).size.height/2 ,

                child: ListView(
physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(25),
                  children: [
                    PlayerTimeBodyStateContainer(

                      salahName: 'الفجر' ,
                      salahTime:cubit.convertTo12HourFormat(cubit.playerTimesModel!.data!.timings!.fajr!),
                      isPlaying:cubit.isFajer,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PlayerTimeBodyStateContainer(
                      salahName: 'الظهر',
                      salahTime : cubit.convertTo12HourFormat(cubit.playerTimesModel!.data!.timings!.dhuhr!),
                      isPlaying: cubit.isDhuhr,
                    ), SizedBox(
                      height: 20,
                    ),
                    PlayerTimeBodyStateContainer(
                      salahName: 'العصر',
                      salahTime: cubit.convertTo12HourFormat(cubit.playerTimesModel!.data!.timings!.asr!),
                      isPlaying: cubit.isAsr,

                    ), SizedBox(
                      height: 20,
                    ),
                    PlayerTimeBodyStateContainer(
                      salahName: 'المغرب',
                      salahTime: cubit.convertTo12HourFormat(cubit.playerTimesModel!.data!.timings!.maghrib!), isPlaying: cubit.isMaghrib,                  ),
                    SizedBox(
                      height: 20,
                    ),
                    PlayerTimeBodyStateContainer(
                      salahName: 'العشاء',
                      salahTime: cubit.convertTo12HourFormat(cubit.playerTimesModel!.data!.timings!.isha!),
                      isPlaying: cubit.isIsha,),
                  ],

                )
              );
    },
)

            ]),
          ));
    },
);
  }
}
