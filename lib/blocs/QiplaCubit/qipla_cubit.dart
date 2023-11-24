import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../model/adhkar.dart';

part 'qipla_state.dart';

class QiplaCubit extends Cubit<QiplaState> {
  QiplaCubit() : super(QiplaInitial());
  static QiplaCubit get(context) => BlocProvider.of(context);
  double qiblaDirection = 0.0;
  Future<double> getQiblaDirection() async {

      // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 0.0;
    }

      emit(QiplaLoading());

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Calculate the Qibla direction
     qiblaDirection = calculateQiblaDirection(
      position.latitude,
      position.longitude,
    );
    emit(QiplaSuccess(qiblaDirection));

    return qiblaDirection;
  }

  double calculateQiblaDirection(double latitude, double longitude) {
    // Coordinates of the Kaaba in Mecca
    const double kaabaLatitude = 21.4225;
    const double kaabaLongitude = 39.8262;

    // Convert degrees to radians
    double lat1 = degreesToRadians(latitude);
    double lon1 = degreesToRadians(longitude);
    double lat2 = degreesToRadians(kaabaLatitude);
    double lon2 = degreesToRadians(kaabaLongitude);

    // Calculate the difference in longitude
    double dLon = lon2 - lon1;

    // Calculate the Qibla direction
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    double qiblaDirection = atan2(y, x);

    // Convert radians to degrees
    qiblaDirection = radiansToDegrees(qiblaDirection);

    // Normalize the Qibla direction to a value between 0 and 360 degrees
    if (qiblaDirection < 0) {
      qiblaDirection += 360;
    }

    return qiblaDirection;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  double radiansToDegrees(double radians) {
    return radians * 180 / pi;
  }

}
