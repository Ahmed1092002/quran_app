import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/blocs/PrayerTimes/prayer_times_api_cubit.dart';
import 'package:quran_app/views/spalsh_screan.dart';
import 'package:provider/provider.dart';
import '../utils/theme_notifire.dart';

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>PrayerTimesApiCubit()..getPrayerTimes()),
      ],
      child: ValueListenableBuilder(
          valueListenable: MyApp.themeNotifier,

          builder: (_, ThemeMode currentMode, __)
      =>MaterialApp(

          debugShowCheckedModeBanner: false,
          theme:ThemeData(



          ).copyWith(
            useMaterial3: true,
backgroundColor: Color(0xFF333333),
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              bodyMedium: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              bodySmall: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          darkTheme:ThemeData.dark(
            useMaterial3: true,

          )
              .copyWith(
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,


            appBarTheme: AppBarTheme(
              backgroundColor: Colors.black,
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                color:  Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              bodyMedium: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              bodySmall: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
            ),
            useMaterial3: true,

          ),



          themeMode: currentMode == ThemeMode.system ? ThemeMode.system : currentMode,
          home: SpalshScrean()
      ),
      ),
    );
  }
}