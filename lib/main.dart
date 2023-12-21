import 'package:bhart_political_reports/Routes/Routes.dart';
import 'package:bhart_political_reports/Screens/Botton_navigation/bottom_navigation_home.dart';
import 'package:bhart_political_reports/Screens/Botton_navigation/local_government.dart';
import 'package:bhart_political_reports/Screens/Home/home.dart';
import 'package:bhart_political_reports/Screens/login.dart';
import 'package:bhart_political_reports/Screens/onBoard/onBoard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child:MyApp()));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BPL',
      //comment this and uncomment blow to use the routes
      // home: BottomNavigationHome(),
      home: Wrapper(),
      theme: ThemeData(primarySwatch: Colors.blue),
      // routes: {
      //   routes.homeRoute:(context)=>BottomNavigationHome(),
      // },

      // routes: {
      //   "/": (context) => OnBoarding(),
      //   routes.loginRoute: (context) => LoginPage(),
      //   routes.homeRoute: (context) => HomePage(),
      //   routes.onBoardFirst: (context) => OnBoarding(),
      // },
      routes: {
        routes.homeRoute: (context) => BottomNavigationHome(),
        routes.loginRoute: (context) => LoginPage(),
        routes.onBoardFirst: (context) => OnBoarding(),
      },

    );
  }
}
//uncomment this to add the all routes

class Wrapper extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          //change user==null to user!=null for production application
           if (user != null) {
            // User is already logged in, navigate to the main app screen
            return BottomNavigationHome();
          } else {
            // User is not logged in, navigate to the onboarding screen
            return OnBoarding();
          }
        } else {
          // While Firebase is checking authentication state, you can show a loading screen
          return CircularProgressIndicator();
        }
      },
    );
  }
}
