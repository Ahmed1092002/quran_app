part of 'prayer_times_api_cubit.dart';

@immutable
abstract class PrayerTimesApiState {}

class PrayerTimesApiInitial extends PrayerTimesApiState {}

class PrayerTimesApiLoading extends PrayerTimesApiState {}

class PrayerTimesApiSuccess extends PrayerTimesApiState {
  final Map<String, dynamic> data;

  PrayerTimesApiSuccess(this.data);
}


