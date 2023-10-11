import 'dart:ui';

import 'package:bhart_political_reports/Screens/login.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                      itemCount: data.length,
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return PageWithBackground(
                          backgroundImage: data[index].image,
                          content: Center(
                            child: onBoardContent(
                              title: data[index].title,
                              subtitle: data[index].subtitle,
                            ),
                          ),
                        );
                      }),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                        data.length,
                        (index) => Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: DotIndicator(
                                isActive: index == _pageIndex,
                              ),
                            )),
                    DotIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "Let's Begin",
                          style: TextStyle(fontSize: 22),
                        ))),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageWithBackground extends StatelessWidget {
  final String backgroundImage;
  final Widget content;

  PageWithBackground({
    required this.backgroundImage,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Image.asset(
            backgroundImage,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        content,
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isActive ? 32 : 16,
      width: 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.blue.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}

class Onboard {
  final String image, title, subtitle;

  Onboard({required this.image, required this.title, required this.subtitle});
}

final List<Onboard> data = [
  Onboard(
      image: "Assets/Images/image/farmers.jpg",
      title: "Indian \nPolitical Report",
      subtitle: "A platform for change"),
  Onboard(
      image: "Assets/Images/image/farmerpage.jpg",
      title: "Indian \nPolitical Analysis",
      subtitle: "A Platform For A Change")
];

class onBoardContent extends StatelessWidget {
  const onBoardContent({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    double textHeight = MediaQuery.of(context).size.height / 1.5;
    return Column(
      children: [
        SizedBox(
          height: textHeight,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10,),
        Text(
          subtitle,
          style: TextStyle(color: Colors.white,fontSize: 18),
        ),
        const Spacer(),
      ],
    );
  }
}
