import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quran_app/blocs/QiplaCubit/qipla_cubit.dart';
import 'package:quran_app/widget/custom_text.dart';
import 'package:vibration/vibration.dart';

import '../generated/assets.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class ElqeplaBody extends StatefulWidget {
  const ElqeplaBody({Key? key}) : super(key: key);

  @override
  State<ElqeplaBody> createState() => _ElqeplaBodyState();
}

class _ElqeplaBodyState extends State<ElqeplaBody> {
  double _compassHeading = 0.0;
  double _qiblaDirection = 0.0;
  StreamSubscription? _accelerometerSubscription;
  StreamSubscription? _compassSubscription;


  @override
  void initState() {
    super.initState();
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
          // Use accelerometer values to adjust the compass heading
          setState(() {
            _compassHeading = event.z * -1.0;
          });
        });

    _compassSubscription = FlutterCompass.events!.listen((CompassEvent event) {
      // Use compass events to update the Qibla direction
      setState(() {
        _qiblaDirection = event.heading!;

      });
    });
  }
  void checkVibrationCondition() {
    double qiblaDirection = QiplaCubit.get(context).qiblaDirection;
    if (_qiblaDirection == _compassHeading - qiblaDirection) {
      Vibration.vibrate(duration: 1000);
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _compassSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QiplaCubit()..getQiblaDirection(),
      child: BlocConsumer<QiplaCubit, QiplaState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          // if (_qiblaDirection ==  QiplaCubit.get(context).qiblaDirection) {
          //   Vibration.vibrate(duration: 1000).whenComplete(() {
          //     Vibration.cancel();
          //   });
          // }
          if (state is QiplaInitial || state is QiplaLoading ) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              child: Center(
                child: Column(
                  children: [
CustomText(
  text: 'القبلة',
),                    SizedBox(
                      height: 150,
                    ),
                    Text('Compass Heading: $_compassHeading'),
                    Text('Qibla Direction: $_qiblaDirection'),
                    Text('Qibla Direction: ${QiplaCubit.get(context).qiblaDirection}'),
                    SizedBox(
                      height: 50,
                    ),

                    Transform.rotate(
                      angle: _qiblaDirection,
                      child: Image.asset(
                        color: Color(0xFFFA7031),
                        Assets.imageCompassImage,
                        width: 200,
                        height: 200,
                      ),
                    ),




                  ],
                ),
              ),

            ),
          );
        },
      ),
    );
  }
}
