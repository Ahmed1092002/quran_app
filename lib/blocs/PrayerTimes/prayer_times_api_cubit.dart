import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:quran_app/model/FajrModel.dart';
import 'package:quran_app/model/PlayerTimesModel.dart';

import '../../generated/assets.dart';
import '../../utils/dio.dart';

part 'prayer_times_api_state.dart';

class PrayerTimesApiCubit extends Cubit<PrayerTimesApiState> {
  PrayerTimesApiCubit() : super(PrayerTimesApiInitial()){
    formattedDate = '${now!.day}-${now!.month}-${now!.year}';
  }

  static PrayerTimesApiCubit get(context) => BlocProvider.of(context);

  PrayerTimesModel? playerTimesModel;


  DateTime? now = DateTime.now();

Timer? timer;

  Duration remainingTime = Duration(hours: 0, minutes: 0, seconds: 0);
  String prayerName = '';
  String prayerNameString = '';
  String formattedPrayerTime = ''; // Declare the variable outside the loop
  late final formattedRemainingTime;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    return await Geolocator.getCurrentPosition();
  }

  Future getPrayerTimes() async {

    emit(PrayerTimesApiLoading());

    Response<dynamic> response = await getFromApi();

    //startTimer();
    if (response.statusCode == 200) {
      playerTimesModel = PrayerTimesModel.fromJson(response.data);
      getNextPlayerTime();

    } else {
    }

    emit(PrayerTimesApiSuccess(response.data));
  }


final nextFormatDare = DateFormat('dd-MM-yyyy');
  String? formattedDate;
  Future<Response<dynamic>> getFromApi() async {

    await _determinePosition();
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    final currentCountry = placemarks.first.country ?? '';
    final currentCity = placemarks.first.locality ?? '';

    var dio = Dio();
    var response = await dio.request(
      'https://api.aladhan.com/v1/timingsByCity/$formattedDate?city=$currentCity&country=$currentCountry&method=8',
      options: Options(
        method: 'GET',
      ),
    );
    return response;
  }
  FajrModel? fajrModel;
  Future  getFajerTime() async {
    DateTime tomorrow = now!.add(Duration(days: 1));
     formattedDate = '${tomorrow.day}-${tomorrow.month}-${tomorrow.year}';
     print ('formattedDate is $formattedDate');
    Response<dynamic> response = await getFromApi();
    if (response.statusCode == 200) {
      fajrModel = FajrModel.fromJson(response.data);
      print ('fajrModel is ${fajrModel!.data!.timings!.fajr}');

    } else {
    }


}
  DateTime? nextPrayerTime;

  getNextPlayerTime() async {

    Duration? duration;


int? hoursRemaining ;
    int? minutesRemaining;
    int? secondsRemaining;
    for (prayerName in playerTimesModel!.data!.timings!.toJson().keys) {
      String prayerTimeString = playerTimesModel!.data!.timings!.toJson()[prayerName];
      DateTime prayerTime = DateTime(
        now!.year,
        now!.month,
        now!.day,
        int.parse(prayerTimeString.split(':')[0]),
        int.parse(prayerTimeString.split(':')[1]),
      );



      if (prayerTime.isAfter(now!)) {
        if (nextPrayerTime == null || prayerTime.isBefore(nextPrayerTime!)) {
          if (prayerName == 'Fajr') {
            prayerNameString = 'الفجر';
          }  else if (prayerName == 'Dhuhr') {
            prayerNameString = 'الظهر';
          } else if (prayerName == 'Asr') {
            prayerNameString = 'العصر';
          } else if (prayerName == 'Maghrib') {
            prayerNameString = 'المغرب';
          } else if (prayerName == 'Isha') {

            prayerNameString = 'العشاء';
          }
          nextPrayerTime = prayerTime;
        }
      }

    }

    if (nextPrayerTime != null) {
      duration = nextPrayerTime!.difference(now!);
      hoursRemaining = duration.inHours;
      minutesRemaining =duration.inMinutes % 60;
      secondsRemaining = duration.inSeconds % 60;

    } else  {
    await  getFajerTime();
      String prayerTimeString = fajrModel!.data!.timings!.fajr!;
      DateTime fajrTime = DateTime(
        now!.year,
        now!.month,
        now!.day,
        int.parse(prayerTimeString.split(':')[0]),
        int.parse(prayerTimeString.split(':')[1]),
      );


      duration = now!.difference(fajrTime);
      duration = Duration(hours: 24) - duration;

      prayerNameString= 'الفجر';
      hoursRemaining = duration.inHours;
      minutesRemaining =duration.inMinutes % 60;
      secondsRemaining = duration.inSeconds % 60;

    }


    remainingTime = duration ?? Duration.zero;

  }
  bool isFajer = false;
  bool isDhuhr = false;
  bool isAsr = false;
  bool isMaghrib = false;
  bool isIsha = false;
  bool isPlaying = false;

  bool play(bool isNowPlaying) {

    final AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.play(
      AssetSource('sounds/a2.mp3'),


    ).then((value) {

        // Voice is playing

    }).whenComplete(() {
      audioPlayer.dispose();

      isNowPlaying = false;
    });

return isNowPlaying; ;

  }
  Stream startTimer() async* {
    if (await FlutterBackground.initialize()) {
      await FlutterBackground.enableBackgroundExecution();
    }
   yield*   Stream.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (remainingTime.inSeconds > 0) {
          remainingTime -= const Duration(seconds: 1);



          if (remainingTime.inSeconds == 0) {
            remainingTime -= const Duration(minutes: 1);

          }
          if (remainingTime.inMinutes == 0) {
            remainingTime -= const Duration(hours: 1);
          }
         if (remainingTime.inHours == 0 && remainingTime.inMinutes == 0 && remainingTime.inSeconds == 0) {


              if (nextPrayerTime!.isAtSameMomentAs(now!)) {
                if (prayerNameString== 'الفجر'|| prayerName=='Fajr'){
                  isFajer = true;

                 isFajer = play(isFajer);

                }
               else  if (prayerNameString== 'العصر' || prayerName=='Asr'){
                 isAsr = true;

                isAsr =  play(isAsr);
                }
            else if (prayerNameString== 'الظهر' || prayerName=='Dhuhr') {
              isDhuhr = true;

                isDhuhr =  play(isDhuhr);
                }
               else if (prayerNameString== 'العشاء' || prayerName=='Isha') {
                 isIsha = true;

               isIsha =  play(isIsha);
                }
              else  if (prayerNameString== 'المغرب') {
                isMaghrib = true;

                isMaghrib =  play(isMaghrib);
                }
                remainingTime = Duration.zero;

                getNextPlayerTime();
              }

            }

        }
      },
    );
   yield remainingTime.toString().split('.').first;

    //yield* timer!.tick;
  }


  String convertTo12HourFormat(String time) {
    final DateFormat format24Hour = DateFormat('HH:mm');
    final DateFormat format12Hour = DateFormat('a\th:mm');

    final DateTime dateTime = format24Hour.parse(time);
    final String convertedTime = format12Hour.format(dateTime);

    return convertedTime.toLowerCase();
  }







}
