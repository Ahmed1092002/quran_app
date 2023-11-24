import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_app/model/JusTextModel.dart';

import '../../model/QuranAudioPlayerModel.dart';

part 'elquran_state.dart';

class ElquranCubit extends Cubit<ElquranState> {
  ElquranCubit() : super(ElquranInitial());
  static ElquranCubit get(context) => BlocProvider.of(context);
  List<String>Jus=[
    'الجزء الأول',
    'الجزء الثاني',
    'الجزء الثالث',
    'الجزء الرابع',
    'الجزء الخامس',
    'الجزء السادس',
    'الجزء السابع',
    'الجزء الثامن',
    'الجزء التاسع',
    'الجزء العاشر',
    'الجزء الحادي عشر',
    'الجزء الثاني عشر',
    'الجزء الثالث عشر',
    'الجزء الرابع عشر',
    'الجزء الخامس عشر',
    'الجزء السادس عشر',
    'الجزء السابع عشر',
    'الجزء الثامن عشر',
    'الجزء التاسع عشر',
    'الجزء العشرون',
    'الجزء الحادي والعشرون',
    'الجزء الثاني والعشرون',
    'الجزء الثالث والعشرون',
    'الجزء الرابع والعشرون',
    'الجزء الخامس والعشرون',
    'الجزء السادس والعشرون',
    'الجزء السابع والعشرون',
    'الجزء الثامن والعشرون',
    'الجزء التاسع والعشرون',
    'الجزء الثلاثون',



  ];
  List<String>surahNames=[
    "سورة الفاتحة",
    "سورة البقرة",
    "سورة آل عمران",
    "سورة النساء",
    "سورة المائدة",
    "سورة الأنعام",
    "سورة الأعراف",
    "سورة الأنفال",
    "سورة التوبة",
    "سورة يونس",
    "سورة هود",
    "سورة يوسف",
    "سورة الرعد",
    "سورة إبراهيم",
    "سورة الحجر",
    "سورة النحل",
    "سورة الإسراء",
    "سورة الكهف",
    "سورة مريم",
    "سورة طه",
    "سورة الأنبياء",
    "سورة الحج",
    "سورة المؤمنون",
    "سورة النور",
    "سورة الفرقان",
    "سورة الشعراء",
    "سورة النمل",
    "سورة القصص",
    "سورة العنكبوت",
    "سورة الروم",
    "سورة لقمان",
    "سورة السجدة",
    "سورة الأحزاب",
    "سورة سبأ",
    "سورة فاطر",
    "سورة يس",
    "سورة الصافات",
    "سورة ص",
    "سورة الزمر",
    "سورة غافر",
    "سورة فصلت",
    "سورة الشورى",
    "سورة الزخرف",
    "سورة الدخان",
    "سورة الجاثية",
    "سورة الأحقاف",
    "سورة محمد",
    "سورة الفتح",
    "سورة الحجرات",
    "سورة ق",
    "سورة الذاريات",
    "سورة الطور",
    "سورة النجم",
    "سورة القمر",
    "سورة الرحمن",
    "سورة الواقعة",
    "سورة الحديد",
    "سورة المجادلة",
    "سورة الحشر",
    "سورة الممتحنة",
    "سورة الصف",
    "سورة الجمعة",
    "سورة المنافقون",
    "سورة التغابن",
    "سورة الطلاق",
    "سورة التحريم",
    "سورة الملك",
    "سورة القلم",
    "سورة الحاقة",
    "سورة المعارج",
    "سورة نوح",
    "سورة الجن",
    "سورة المزمل",
    "سورة المدثر",
    "سورة القيامة",
    "سورة الإنسان",
    "سورة المرسلات",
    "سورة النبأ",
    "سورة النازعات",
    "سورة عبس",
    "سورة التكوير",
    "سورة الإنفطار",
    "سورة المطففين",
    "سورة الإنشقاق",
    "سورة البروج",
    "سورة الطارق",
    "سورة الأعلى",
    "سورة الغاشية",
    "سورة الفجر",
    "سورة البلد",
    "سورة الشمس",
    "سورة الليل",
    "سورة الضحى",
    "سورة الشرح",
    "سورة التين",
    "سورة العلق",
    "سورة القدر",
    "سورة البينة",
    "سورة الزلزلة",
    "سورة العاديات",
    "سورة القارعة",
    "سورة التكاثر",
    "سورة العصر",
    "سورة الهمزة",
    "سورة الفيل",
    "سورة قريش",
    "سورة الماعون",
    "سورة الكوثر",
    "سورة الكافرون",
    "سورة النصر",
    "سورة المسد",
    "سورة الإخلاص",
    "سورة الفلق",
    "سورة الناس",




  ];
  List<String>quranAudioPlayerList = [
    'الشيخ الاول',
    'الشيخ الثاني',
    'الشيخ الثالث',
    'الشيخ الرابع',
    'الشيخ الخامس',

  ];
  List<String>NumberOfSurahs =[];

  JusTextModel? jusTextModel;
  QuranAudioPlayerModel? quranAudioPlayerModel;

 Future getJus({required int juzNumber,}) async{
emit(ElquranGetJusLoadingState());
    var dio = Dio();
    var response = await dio.request(
      'http://api.alquran.cloud/v1/juz/${juzNumber}/ar.asad',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      jusTextModel = JusTextModel.fromJson(response.data);
      emit(ElquranGetJusSuccessState());


      // Map<int, Map<String, String>> pageMap = {};
      // for (var ayah in jusTextModel!.data!.ayahs!) {
      //   int page = ayah.page!;
      //   String surahName = ayah.surah!.name!;
      //   String text = ayah.text!;
      //    surahText += text;
      //
      //   if (!pageMap.containsKey(page)) {
      //     pageMap[page] = {surahName: text};
      //   } else {
      //     if (!pageMap[page]!.containsKey(surahName)) {
      //       if (pageMap[page]![surahName] == null) {
      //         pageMap[page]![surahName] = text;
      //       } else {
      //         pageMap[page]![surahName] = ' ' + surahText;
      //       }
      //     }
      //   }
      // }
      //
      // print(pageMap);

      print(json.encode(response.data));
    }
    else {
      emit(ElquranGetJusErrorState());
      print(response.statusMessage);
    }


  }

  Future getQuranAudioPlayer() async{
   emit(ElquranGetAudioSurahLoadingState());

   var headers = {
     'Cookie': 'XSRF-TOKEN=eyJpdiI6IklSeThaZ3M3ejkrQjM1ZzBoZnZxRUE9PSIsInZhbHVlIjoiMHkvb0hUaENOVWQ0dW03R0hjK2N0ZUhLMEl3UkE1NW9JdTIvTDJaMVJOQ2llcUYzMndYa0RlK1ErNVRISWwvU2NtT0sxaW5rZ0M2SWdZaTdHTTdQY1N5TDdnVGREZFVNbitnbE5zVmoyQVg1UDc2WE0yN2xubkxWTFZwem9jdUsiLCJtYWMiOiJhMDc1ZGQwNTZiNGQ0MTk4N2U3MGM0ZDNjMmY5YmU0MGY2MmQ4YjBjN2RlMjgzYjVmYjY1YmI4YmI4NmI5ZjI2IiwidGFnIjoiIn0%3D; mp3quran_session=eyJpdiI6IlNFdkZ5V2xnbVZwOHlmVzZtVm8vdGc9PSIsInZhbHVlIjoicStGZG5WQ0J6QWVLY2twUGdta3pzaVJ4VXl0Y0tvMlFjWml5d05pN2d0ODVuZ0pLTktRWHk3SlMwTEpVbS9VYUl5aFRSeTBmQ0hwR1I4MVRqS2VyQ3dQOStUSWhmclM5N28xNVJUTU5RdDNMNVAwR3ZqMC84aUhJQllkUmQ1RmEiLCJtYWMiOiJlNzA4ZDdjYWM0ODg4NjA0OThmYzQyM2NlOWRlNzU2NzliNWZmMjgyNWNmZTlmMTY5ZTU2NzM3MjczNmI5MTI4IiwidGFnIjoiIn0%3D'
   };
   var dio = Dio();
   var response = await dio.request(
     'https://www.mp3quran.net/api/v3/reciters?language=ar',
     options: Options(
       method: 'GET',
       headers: headers,
     ),
   );

   if (response.statusCode == 200) {

      quranAudioPlayerModel = QuranAudioPlayerModel.fromJson(response.data);

      emit(ElquranGetAudioSurahSuccessState());
   }
   else {
     print(response.statusMessage);
      emit(ElquranGetAudioSurahErrorState());
   }

  }








}
