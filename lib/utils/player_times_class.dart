import 'package:dio/dio.dart';
import 'package:quran_app/utils/dio.dart';

class PrayerTimesApi {
  static Future<Response> getPrayerTimes({
    required String date,
    required String city,
    required String country,
    required int method,
  }) async {
    final url = 'https://api.aladhan.com/v1/timingsByCity/$date';
    final query = {
      'city': city,
      'country': country,
      'method': method.toString(),
    };

    return await DioHelper.getData(url: url, query: query);
  }
}