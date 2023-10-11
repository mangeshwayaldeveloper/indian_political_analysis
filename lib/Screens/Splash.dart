import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late FlutterGifController controller;

  void initState() {
    super.initState();
    controller = FlutterGifController(vsync: this);
    Timer(Duration(milliseconds: 5080),
        () => Navigator.pushReplacementNamed(context, '/onBoardFirst'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x2A2222),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("Assets/Images/image/fingerprintFrontPage.jpg",height: 200,)
            ],
          ),
        ),
      ),
    );
  }
}
