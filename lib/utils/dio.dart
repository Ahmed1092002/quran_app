import 'package:dio/dio.dart';

class DioHelper {

  static Dio? dio;

  // static init(){
  //   dio=Dio(
  //       BaseOptions(
  //         baseUrl: 'https://api.weatherapi.com/v1/',
  //         receiveDataWhenStatusError: true,
  //       )
  //   );
  // }

  static Future<Response> getData(
      {
    required String url,
    Map<String,dynamic> ?query,
  }
  )
  async {

    return await dio!.get(url,queryParameters:query );
  }


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


  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) {

    dio!.options.headers = {
      'content-type':'application/json',
    };
    return dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio!.options.headers = {
      'content-type': 'application/json',
    };
    return await dio!.put(url, queryParameters: query, data: data);
  }


  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'content-type': 'application/json',
    };
    return await dio!.delete(url, queryParameters: query);
  }




}