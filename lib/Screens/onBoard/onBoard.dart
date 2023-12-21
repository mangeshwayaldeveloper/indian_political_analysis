import 'package:bhart_political_reports/Screens/login.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    // ...List.generate(
                    //     data.length,
                    //     // (index) => Padding(
                        //       padding: EdgeInsets.only(right: 4),
                        //       child: DotIndicator(
                        //         isActive: index == _pageIndex,
                        //       ),
                        //     )),
                    // DotIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xd730ee18)
                      ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "Let's Begin",
                          style: TextStyle(fontSize: 22),
                        ))),
                SizedBox(
                  height: 25,
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
          child: DropShadowImage(
            image: Image.asset(backgroundImage),
            offset: Offset(10, 10),
            // scale: 1.05,
          ),
        ),
        content,
      ],
    );
  }
}

// class DotIndicator extends StatelessWidget {
//   const DotIndicator({
//     super.key,
//     this.isActive = false,
//   });
//
//   final bool isActive;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 300),
//       height: isActive ? 32 : 16,
//       width: 8,
//       decoration: BoxDecoration(
//           color: isActive ? Colors.blue : Colors.blue.withOpacity(0.4),
//           borderRadius: BorderRadius.all(Radius.circular(12))),
//     );
//   }
// }

class Onboard {
  final String image, title, subtitle;

  Onboard({required this.image, required this.title, required this.subtitle});
}

final List<Onboard> data = [
  Onboard(
      image: "Assets/Images/image/ipa.jpg",
      title: "INDIAN POLITICIAN\n ANALYSIS",
      subtitle: "A Platform For Change\n\n\n\n Just \u{20B9}99 For 5 Years"),
];
// \u{20B9}
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
    double textHeight = MediaQuery.of(context).size.height / 1.7;
    return Column(
      children: [
        SizedBox(
          height: textHeight,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white,fontFamily:'ArchivoBlack'),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        const Spacer(),
      ],
    );
  }
}
