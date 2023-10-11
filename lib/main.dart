import 'package:bhart_political_reports/Routes/Routes.dart';
import 'package:bhart_political_reports/Screens/Home/home.dart';
import 'package:bhart_political_reports/Screens/Splash.dart';
import 'package:bhart_political_reports/Screens/login.dart';
import 'package:bhart_political_reports/Screens/onBoard/onBoard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BPL',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        "/": (context) =>Splash(),
        routes.loginRoute: (context) => LoginPage(),
        routes.homeRoute: (context) => HomePage(),
        routes.onBoardFirst: (context) => OnBoarding(),
      },
    );
  }
}
