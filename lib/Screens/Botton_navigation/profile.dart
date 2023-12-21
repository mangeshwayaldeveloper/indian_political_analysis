import 'package:bhart_political_reports/model/categories/economy.dart';
import 'package:bhart_political_reports/model/categories/education.dart';
import 'package:bhart_political_reports/model/categories/governance.dart';
import 'package:bhart_political_reports/model/categories/healthcare.dart';
import 'package:bhart_political_reports/model/categories/pollution.dart';
import 'package:bhart_political_reports/model/categories/transport.dart';
import 'package:bhart_political_reports/model/categories/womenssecurity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/categories/electricity.dart';
import '../login.dart';

class Profile extends ConsumerStatefulWidget {
  Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a FirebaseAuth instance
  String _userName = "Loading...";

  @override
  Widget build(BuildContext context) {
    final educationDataAsyncValue = ref.watch(ratingProvider);
    final economyDataAsyncValue = ref.watch(economyRatings);
    final electricityDataAsyncValue = ref.watch(electricityRatings);
    final governanceDataAsyncValue = ref.watch(governanceRatings);
    final healthcareDataAsyncValue = ref.watch(healthcareRatings);
    final pollutionDataAsyncValue = ref.watch(pollutionRatings);
    final transportDataAsyncValue = ref.watch(transportRatings);
    final womensSecDataAsyncValue = ref.watch(womensSecurityRatings);

    var educational;
    var economy;
    var electricity;
    var governance;
    var healthcare;
    var pollution;
    var transport;
    var womenssecurity;
    educationDataAsyncValue.when(
      data: (snapshot) {
        // Access the data using snapshot.data
        var data = snapshot.data() as Map<String, dynamic>?;

        if (data == null) {
          // Handle the case where data is null
          return Center(child: Text('No data available'));
        }

        // Extract rating and timestamp from data
        educational = data['rating'];
        var timestamp = data['timestamp'];
        print(educational);
        print(timestamp);
        // Convert timestamp to a human-readable format
        var formattedTimestamp = DateTime.fromMillisecondsSinceEpoch(
            timestamp.seconds * 1000 + timestamp.nanoseconds ~/ 1000000);
        print(formattedTimestamp);
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
    economyDataAsyncValue.when(
      data: (snapshot) {
        // Access the data using snapshot.data
        var data = snapshot.data() as Map<String, dynamic>?;

        if (data == null) {
          // Handle the case where data is null
          return Center(child: Text('No data available'));
        }

        // Extract rating and timestamp from data
        economy = data['rating'];
        var timestamp = data['timestamp'];
        print(timestamp);
        // Convert timestamp to a human-readable format
        var formattedTimestamp = DateTime.fromMillisecondsSinceEpoch(
            timestamp.seconds * 1000 + timestamp.nanoseconds ~/ 1000000);
        print(formattedTimestamp);
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
    electricityDataAsyncValue.when(
      data: (snapshot) {
        // Access the data using snapshot.data
        var data = snapshot.data() as Map<String, dynamic>?;

        if (data == null) {
          // Handle the case where data is null
          return Center(child: Text('No data available'));
        }

        // Extract rating and timestamp from data
        electricity = data['rating'];
        var timestamp = data['timestamp'];
        print(timestamp);
        // Convert timestamp to a human-readable format
        var formattedTimestamp = DateTime.fromMillisecondsSinceEpoch(
            timestamp.seconds * 1000 + timestamp.nanoseconds ~/ 1000000);
        print(formattedTimestamp);
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
    governanceDataAsyncValue.when(
      data: (snapshot) {
        // Access the data using snapshot.data
        var data = snapshot.data() as Map<String, dynamic>?;

        if (data == null) {
          // Handle the case where data is null
          return Center(child: Text('No data available'));
        }

        // Extract rating and timestamp from data
        governance= data['rating'];
        var timestamp = data['timestamp'];
        print(timestamp);
        // Convert timestamp to a human-readable format
        var formattedTimestamp = DateTime.fromMillisecondsSinceEpoch(
            timestamp.seconds * 1000 + timestamp.nanoseconds ~/ 1000000);
        print(formattedTimestamp);
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
    healthcareDataAsyncValue.when(
      data: (snapshot) {
        // Access the data using snapshot.data
        var data = snapshot.data() as Map<String, dynamic>?;

        if (data == null) {
          // Handle the case where data is null
          return Center(child: Text('No data available'));
        }

        // Extract rating and timestamp from data
        healthcare= data['rating'];
        var timestamp = data['timestamp'];
        print(timestamp);
        // Convert timestamp to a human-readable format
        var formattedTimestamp = DateTime.fromMillisecondsSinceEpoch(
            timestamp.seconds * 1000 + timestamp.nanoseconds ~/ 1000000);
        print(formattedTimestamp);
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
    pollutionDataAsyncValue.when(
      data: (snapshot) {
        // Access the data using snapshot.data
        var data = snapshot.data() as Map<String, dynamic>?;

        if (data == null) {
          // Handle the case where data is null
          return Center(child: Text('No data available'));
        }

        // Extract rating and timestamp from data
        pollution= data['rating'];
        var timestamp = data['timestamp'];
        print(timestamp);
        // Convert timestamp to a human-readable format
        var formattedTimestamp = DateTime.fromMillisecondsSinceEpoch(
            timestamp.seconds * 1000 + timestamp.nanoseconds ~/ 1000000);
        print(formattedTimestamp);
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );

    transportDataAsyncValue.when(
      data: (snapshot) {
        // Access the data using snapshot.data
        var data = snapshot.data() as Map<String, dynamic>?;

        if (data == null) {
          // Handle the case where data is null
          return Center(child: Text('No data available'));
        }

        // Extract rating and timestamp from data
        transport= data['rating'];
        var timestamp = data['timestamp'];
        print(timestamp);
        // Convert timestamp to a human-readable format
        var formattedTimestamp = DateTime.fromMillisecondsSinceEpoch(
            timestamp.seconds * 1000 + timestamp.nanoseconds ~/ 1000000);
        print(formattedTimestamp);
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );

    womensSecDataAsyncValue.when(
      data: (snapshot) {
        // Access the data using snapshot.data
        var data = snapshot.data() as Map<String, dynamic>?;

        if (data == null) {
          // Handle the case where data is null
          return Center(child: Text('No data available'));
        }

        // Extract rating and timestamp from data
        womenssecurity= data['rating'];
        var timestamp = data['timestamp'];
        print(timestamp);
        // Convert timestamp to a human-readable format
        var formattedTimestamp = DateTime.fromMillisecondsSinceEpoch(
            timestamp.seconds * 1000 + timestamp.nanoseconds ~/ 1000000);
        print(formattedTimestamp);
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                backgroundImage:
                    AssetImage("Assets/Images/image/userprofileIcon.png"),
                radius: 60,
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  "User Profile",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Your Daily Activity Track"),
              SizedBox(
                height: 25,
              ),
              Image.asset(
                "Assets/Images/image/graph.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Ratings",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(child: Text("$economy"))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 10),
                          child: Text(
                            "Healthcare",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(child: Text("$educational")
                                  // "${(educationRating / 5.0 * 100).floor()}%"),
                                  )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 10),
                          child: Text(
                            "Education",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(child: Text("$transport"))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 10),
                          child: Text(
                            "Transport",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(child: Text("$womenssecurity"))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 10),
                          child: Text(
                            "Womens",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(child: Text("$electricity"))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 10),
                          child: Text(
                            "Electricity",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(child: Text("$pollution"))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 10),
                          child: Text(
                            "Pollution",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                  child: Text(
                                      "$economy"))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 10),
                          child: Text(
                            "Economy",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(child: Text("$governance"))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 10),
                          child: Text(
                            "Governance",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent,
                ),
                child: TextButton(
                    onPressed: () {
                      _signOut();
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      // After signing out, you can navigate to the login screen or any other screen
      // For example, you can navigate back to your login page
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            LoginPage(), // Replace with your actual login page
      ));
    } catch (e) {
      print('Error signing out: $e');
      // Handle any errors that occur during sign-out
    }
  }
}
