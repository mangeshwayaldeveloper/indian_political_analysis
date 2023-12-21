import 'package:bhart_political_reports/Screens/Botton_navigation/local_government.dart';
import 'package:bhart_political_reports/Screens/Botton_navigation/profile.dart';
import 'package:bhart_political_reports/Screens/Botton_navigation/Rate.dart';
import 'package:flutter/material.dart';

import '../Home/home.dart';
import 'mla.dart';

class BottomNavigationHome extends StatefulWidget {
  @override
  State<BottomNavigationHome> createState() => _BottomNavigationHomeState();
}

class _BottomNavigationHomeState extends State<BottomNavigationHome> {
  int currentTab = 0;

  final List<Widget> screens = [
    HomePage(),
    LocalGovernment(),
    MLA(),
    CategoryData(),
    Profile()
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home,
                            color: currentTab == 0 ? Colors.blue : Colors.grey),
                        Text(
                          "Home",
                          style: TextStyle(
                              color:
                              currentTab == 0 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = LocalGovernment();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("Assets/Images/bottomNavigation/local.png",height: 25,
                            color: currentTab == 1 ? Colors.blue : Colors.grey),
                        Text(
                          "Local",
                          style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = MLA();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("Assets/Images/bottomNavigation/mla.png",height: 25,
                            color: currentTab == 2 ? Colors.blue : Colors.grey),
                        Text(
                          "MLA",
                          style: TextStyle(
                              color:
                              currentTab == 2 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = CategoryData();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("Assets/Images/bottomNavigation/all.png",height: 25,
                            color: currentTab == 3 ? Colors.blue : Colors.grey),
                        Text(
                          "Rate",
                          style: TextStyle(
                              color:
                              currentTab == 3 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Profile();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person,
                            color: currentTab == 4 ? Colors.blue : Colors.grey),
                        Text(
                          "Profile",
                          style: TextStyle(
                              color:
                              currentTab == 4 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
