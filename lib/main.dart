import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/src/app_root.dart';
import 'package:quran_app/utils/bloc_Opserver.dart';
import 'package:flutter_background/flutter_background.dart';

import 'firebase_options.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "flutter_background example app",
    notificationText: "Background notification for keeping the example app running in the background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'), // Default is ic_launcher from folder mipmap
  );
  bool success = await FlutterBackground.initialize(androidConfig: androidConfig);
  bool hasPermissions = await FlutterBackground.hasPermissions;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}



