import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Healthcare extends ConsumerStatefulWidget {
  const Healthcare({super.key});

  @override
  ConsumerState<Healthcare> createState() => _HealthcareState();
}

final healthcareProvider = StateProvider<double>((ref) => 0.0);

class _HealthcareState extends ConsumerState<Healthcare> {
  double userRating = 0.1; // Initial rating
  int totalDays = 0;
  double totalRating = 0.0;

  double get averageRating => totalDays > 0 ? totalRating / totalDays : 0.0;
  bool ratingSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Healthcare",
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(height: 10,),
              Image.asset("Assets/Images/category/healthcare.jpg"),
              SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rating: ${(userRating / 5.0 * 100).toStringAsFixed(0)}%',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: userRating / 5.0,
                    minHeight: 10,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                  SizedBox(height: 20),
                  Slider(
                    value: userRating,
                    min: 0.1,
                    max: 5.0,
                    onChanged: (value) {
                      setState(() {
                        userRating = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      print('User Rating: $userRating');
                      final user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        final category = 'healthcare'; // Replace with the actual category
                        final ratingData = {
                          'rating': (userRating / 5.0 * 100).toStringAsFixed(0),
                          'timestamp': FieldValue.serverTimestamp(),
                        };

                        // Use the user's UID as the document ID
                        final userUid = user.uid;

                        // Add the rating to the user's document directly under the specified category
                        await FirebaseFirestore.instance
                            .collection('ratings')
                            .doc(userUid)
                            .collection(category)
                            .add(ratingData);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Rating submitted: ${(userRating / 5.0 * 100).toStringAsFixed(0)}%'),
                          ),
                        );

                        // Clear the rating bar
                        setState(() {
                          userRating = 0.1;
                        });
                      }
                    },
                    child: Text('Submit Rating'),
                  ),
                  Text("User Rating $userRating"),
                ],
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
