import 'package:bhart_political_reports/Screens/categories/economy.dart';
import 'package:bhart_political_reports/Screens/categories/education.dart';
import 'package:bhart_political_reports/model/carousel_model.dart';
import 'package:bhart_political_reports/model/homePageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

import '../categories/electricity.dart';
import '../categories/governanace.dart';
import '../categories/healthcare.dart';
import '../categories/pollution.dart';
import '../categories/transport.dart';
import '../categories/womens_sercurity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Create a FirebaseAuth instance
  String _userName = "Loading...";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<String> rate = [
    "Healthcare",
    "Education",
    "Transport",
    "Women Security",
    "Electricity",
    "Pollution",
    "Economy",
    "Governance",
  ];
  List pictures = [
    "Assets/Images/rate/healthcare.png",
    "Assets/Images/rate/education.png",
    "Assets/Images/rate/transportation.png",
    "Assets/Images/rate/womens.png",
    "Assets/Images/rate/electricity.png",
    "Assets/Images/rate/pollution.png",
    "Assets/Images/rate/economy.png",
    "Assets/Images/rate/governance.png",
  ];

  Future<void> fetchUserName() async {
    try {
      // Get the current user
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        String? username = currentUser
            .displayName; // Assuming the username is stored in the displayName field

        // Fetch the user's name from Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(username).get();

        if (userDoc.exists) {
          setState(() {
            _userName = userDoc.get('name');
            print(_userName);
          });
        }
      }
    } catch (e) {
      print('Error fetching user name: $e');
      setState(() {
        _userName = "Error";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  @override
  Widget build(BuildContext context) {
    final list = upcomingEventModel.list;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              //promo section
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8.0, bottom: 8.0),
                            child: Text(
                              'IPA',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Image.asset(
                            "Assets/logobgblack.png",
                            height: 50,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.person),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 5, right: 5),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 190,
                      child: Swiper(
                        onIndexChanged: (index) {
                          setState(() {
                            _current = index;
                          });
                        },
                        autoplay: true,
                        layout: SwiperLayout.DEFAULT,
                        itemCount: carousels.length,
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: AssetImage(carousels[index].image),
                                    fit: BoxFit.cover)),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: map<Widget>(carousels, (index, image) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              height: 6,
                              width: 6,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? Colors.blue
                                      : Colors.grey),
                            );
                          }),
                        )
                      ],
                    )
                  ],
                ),
              ),
              // service section
              Padding(
                padding: EdgeInsets.only(left: 18, top: 24),
                child: Text(
                  'Hey Mangesh! How is it going ?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rate.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Healthcare()));
                          case 1:
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Education()));
                          case 2:
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Transport()));
                          case 3:
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WomensSecurity()));
                          case 4:
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Electricity()));
                          case 5:
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Pollution()));
                          case 6:
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Economy()));
                          case 7:
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Governance()));
                        }
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: ClipOval(
                                    child: Image.asset(
                                  pictures[index],
                                )),
                              ),
                            ),
                            Center(
                              child: Text(
                                rate[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              // TextButton(
              //     onPressed: () {
              //       _signOut();
              //     },
              //     child: Text("Logout"))
              // ListView.builder(itemBuilder: itemBuilder)
            ],
          ),
        ),
      ),
    );
  }
// Future<void> _signOut() async {
//   try {
//     await _auth.signOut();
//     // After signing out, you can navigate to the login screen or any other screen
//     // For example, you can navigate back to your login page
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//       builder: (context) =>
//           LoginPage(), // Replace with your actual login page
//     ));
//   } catch (e) {
//     print('Error signing out: $e');
//     // Handle any errors that occur during sign-out
//   }
// }
}
